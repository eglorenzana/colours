module ColorModule
  module Spaces
    # Model super classs for create colors
    class ColorModel
      alias read_attribute_for_serialization send
      NUM_DEC_DIGITS = 4
      attr_reader :components
      attr_reader :model_name, :model_converter
      
      def initialize(params)
        @components = []
        begin
          @model_name = params.fetch(:name).to_sym
          components = params.fetch(:components)
          valid_ranges = params.fetch(:valid_ranges)
          initialize_components(components, valid_ranges)
        rescue KeyError => _e
          raise ColorModelError.new(msg: 'Argument error, you must define name, components and valid_ranges for each one')
        end
        @model_converter = params[:model_converter] || Converters::ColorModelConverter
      end
      def active_model_serializer
          ColorModule::Serializers::ColorModelSerializer
      end    

      def active_model_serializer
        ColorModule::Serializers::ColorModelSerializer
      end

      def assign_components(*values)
        values = values.flatten.first(@components.size).compact
        values.each_with_index do |v, index|
          @components[index].value = v.round(NUM_DEC_DIGITS)
        end
      end
        
      def component_names
        @components.map(&:name)
      end

      def component_values
        @components.map(&:value)
      end

      def resume
        @model_name.to_s + '  with components  ' + @components.map(&:resume).join(', ')
      end

      def components_to_hash
        @components.map(&:to_h).reduce(:merge)
      end
      
      def components_to_hash
        @components.map(&:to_h).reduce(:merge)
      end

      def convert_to(model_to)
        @model_converter.new(self).perform_conversion(model_to)
      end

      def eql?(other)
        first_part = %i[class model_name].all? do |method_name|
          send(method_name) == other.send(method_name)
        end
        first_part &&
          [@components, other.components]
            .transpose.all? { |self_c, another_c| self_c.eql?(another_c) }
      end

      private_class_method

      def self.meta_component_accessors(model_as_self)
        model_as_self.components.each do |cc|
          define_method(cc.name.to_s) do
            components.select { |c| c.name == cc.name }.first.value
          end
          define_method("#{cc.name}=") do |arg|
            components.select { |c| c.name == cc.name }.first.value = arg
          end
        end
      end

      private

      def initialize_components(components, valid_ranges)
        raise ColorModelError unless components.length == valid_ranges.length
        components.each_with_index do |c, index|
          @components << ColorComponent.new(c, valid_ranges[index])
        end
        self.class.meta_component_accessors(self)
      end
    end
  end
end
