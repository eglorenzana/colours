# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ColorModule
  module Spaces
    class ColorModelError < StandardError
      def initialize(params={})
        default_params = {msg: 'Range value error in ColorModel'}.merge(params)
        super(default_params.fetch(:msg, ''))
      end
    end  
    class ColorModel
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
        @model_converter = params[:model_converter] || ColorModelConverter
      end

      def assign_components(*values)
        _values =  values.flatten
        @components.each_with_index do |cc, index|
          cc.value= _values[index]
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
        #puts "", "-"*30, "#{self.model_name}  #{self.resume}"
        @model_converter.new(self).perform_conversion(model_to)
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
