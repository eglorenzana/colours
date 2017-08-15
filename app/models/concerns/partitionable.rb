#expose the interface of partitionable objects
module Partitionable
  class PartitionableError < StandardError    
  end

  def define_parts(*arg,  **options)
    list =  arg.flatten
    main_class =  self
    part_duck =  options.fetch(:part_interface, PhysicalColorPart)
    part_manager_class =  options.fetch(:part_manager_association, Partitionable::PartAssociationManager)
      define_method(:part_managers) do
        @part_managers ||= part_manager_class.build_managers(main_class,list)
        unless @manager_binded
          @part_managers.each {|manager| manager.bind_instance(self) }
          @manager_binded = true
        end
        @part_managers
      end     
      
      validations_for_parts unless respond_to?(:run_part_validations)

      define_method(:is_part_duck?) do  |part|
        part.is_a?(part_duck)
      end
      
      define_method(:add_part) do |part, percentage= 0|
        begin
          add_part!(part, percentage)
        rescue PartitionableError => e
            return false
        end
      end
      
      define_method(:add_part!) do |part, percentage= 0|
        added =  false
        if (self.run_part_validations(part) && 
            (manager = part_managers.get_manager(part)) &&
              part_managers.allow_add_percentage(percentage)) 
          begin
            added = manager.add_part(part, percentage) 
          rescue ActiveRecord::AssociationTypeMismatch,  ActiveRecord::ActiveRecordError => e
            raise PartitionableError.new("The part '#{part.name}' was not added \n due to:\n #{e}" )
          end            
        else
          raise PartitionableError.new("The part '#{part.try(:name)}' was not added, due to validations or quantity overcome 100" )
        end
        added
      end
      
      define_method(:parts) do
        part_managers.flat_map(&:get_collection_parts)
      end
      define_method(:recipe) do |compacted=false|
        recipe = Hash.new
        part_managers.each do |manager|
          parts_recipe = compacted ? manager.compact_recipe : manager.recipe
          recipe[manager.object_assoc_name.to_s.pluralize.to_sym] =  parts_recipe unless parts_recipe.empty?
        end
        recipe.define_singleton_method(:to_string) do 
          s = ''
          r = ["The #{main_class.name.humanize} is composed of"]
          self.each do |key, data|
            r << "\n\t#{key}: "
            kind =  []
            data.each do |obj_part, quantity|
              kind << "\n\t   %3s%c of %s" %[quantity, '%' ,obj_part.description]
            end
            r << kind.join(',')
          end
          s << r.join unless self.empty?
          s
        end
        recipe
      end
      
      
    
  end
  
  def validations_for_parts(*arg, **params)
    arg = arg.flatten + [:is_part_duck?]
    class_eval do
      define_method(:run_part_validations) do  |part|
        arg.uniq.all? do |method|
          send(method.to_sym, part)
        end
      end
    end
  end

  class PartAssociationManager
    extend AssociationData
    def self.build_managers(main_object_klass, *list)
      association_data = get_association_data(main_object_klass, list)
      managers =  Array.new
      association_data.each do |assoc_name, data|
        managers << self.new(main_object_klass, assoc_name, data)
      end
      
      managers.define_singleton_method(:accept_object?) do |obj|
        any?{|manager| manager.accept_object?(obj)}
      end
      
      managers.define_singleton_method(:get_manager) do |obj|
        select{|manager|  manager.accept_object?(obj)}.first
      end
      managers.define_singleton_method(:total_percentage) do
        map(&:get_percentage).reduce(:+)
      end      
      managers.define_singleton_method(:allow_add_percentage) do |quantity|
        total_percentage + quantity <= 100
      end

      managers
    end
    attr_reader :assoc_name, :klass, :object_part_klass, :object_assoc_name
    attr_reader :managed_object_klass, :main_instance
    def initialize(main_object_klass, assoc_name, params={} )
      @managed_object_klass = main_object_klass
      @assoc_name =  assoc_name
      @klass =  params.fetch(:klass)
      @object_part_klass =  params.fetch(:object_part_klass)
      @object_assoc_name = params.fetch(:object_assoc_name)
      @main_instance =  nil
    end
    
    def bind_instance(obj)
      @main_instance ||=  obj if obj.instance_of?(@managed_object_klass)
    end
    
    def accept_object?(obj)
      obj.is_a?(@object_part_klass)
    end
    
    
    def get_percentage
      get_collection_assoc.map(&:percentage).reduce(:+).to_i
    end
    
    def add_part(obj, quantity)
      wrapped = []
      collection_assoc = get_collection_assoc
      collection_part = get_collection_parts #los nombres deben ser unicos
      wrapped = wrap(obj, quantity)
      collection_assoc << wrapped
      wrapped
    end
    
    def get_collection_parts
      get_collection_assoc.flat_map{ |assoc_obj| get_obj(assoc_obj)}
    end
    
    def recipe
      get_collection_assoc.map{|assoc_obj| [get_obj(assoc_obj), assoc_obj.percentage]}.compact
    end
    
    def compact_recipe
      recipe.group_by{|part, _quantity| part.name}.map do |name, recipes|
        [recipes.first.first.name, recipes.map{|_part, percentage| percentage}.reduce(:+)]
      end
    end
    
    private
    def get_collection_assoc
      main_instance.send(assoc_name)
    end
           
    def get_obj(assoc_obj)
      assoc_obj.send(object_assoc_name)
    end    
   
    def wrap(obj, quantity)
      attributes =  Hash.new
      attributes[object_assoc_name] = obj
      attributes[:percentage] = quantity
      klass.new(attributes)
    end
    
  end
  
end
