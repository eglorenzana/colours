module ColorModule
  module Spaces  
    class ColorModel
      NUM_DEC_DIGITS =  4
      attr_reader :components
      attr_reader :model_name, :model_converter

      def initialize(params)
        @components = Array.new
        begin
          @model_name = params.fetch(:name).to_sym
          _components =  params.fetch(:components)
          _valid_ranges = params.fetch(:valid_ranges)
          if _components.length == _valid_ranges.length
            _components.each_with_index do |c, index|
              @components << ColorComponent.new(c, _valid_ranges[index])
            end
            ColorModel.meta_component_accessors(self)
          else
            raise ColorModelError.new
          end          
        rescue KeyError => e
          raise ColorModelError.new(msg: 'Argument error, you must define name, components and valid_ranges for each one')
        end
        @model_converter = params[:model_converter] || Converters::ColorModelConverter
      end

      def assign_components(*values)
        values =  values.flatten.first(@components.size).compact
        values.each_with_index do |v, index|
          @components[index].value= v.round(NUM_DEC_DIGITS)
        end			
      end

      def component_names
        @components.map(&:name)
      end

      def component_values
        @components.map(&:value)
      end

      def resume
        @model_name.to_s + '  with components  ' + @components.map(&:resume).join(", ")
      end

      def convert_to(model_to)
         @model_converter.new(self).perform_conversion(model_to)
      end
      
      def eql?(another_model)
        first_part = [:class, :model_name].all? { |method_name|
          self.send(method_name) == another_model.send(method_name)
        }
        first_part  && ([@components, another_model.components].
          transpose.all?{|self_c, another_c| self_c.eql?(another_c) })
      end
    private
      def self.meta_component_accessors(model_as_self)
        #puts "model_as_self  #{model_as_self} "
          model_as_self.class.class_eval do
            model_as_self.components.each do |cc|
            define_method("#{cc.name}") do
              components.select{|c| c.name == cc.name}.first.value
            end        
            define_method("#{cc.name}=") do |arg|
              components.select{|c| c.name == cc.name}.first.value= arg
            end        
          end
        end
      end

    end
  end
end
