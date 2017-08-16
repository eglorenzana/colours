module ColorModule
  module Serializers
    # Serializer for color
    class ColorSerializer < ActiveModel::Serializer
      attributes :color, :from

      def color
        ColorModelSerializer.new(object.model, instance_options)
      end

      def from
        return nil unless object.instance_variable_defined?('@from_color')
        ColorSerializer.new(object.instance_variable_get('@from_color'),
                            instance_options)
      end
    end
  end
end
