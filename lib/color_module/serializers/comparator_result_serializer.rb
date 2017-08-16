module ColorModule
  module Serializers
    # Serializer for color comparator result
    class ComparatorResultSerializer < ActiveModel::Serializer
      attributes :value, :compared_colors

      def compared_colors
        {
          color1: ColorModelSerializer.new(object.color1, instance_options),
          color2: ColorModelSerializer.new(object.color2, instance_options)
        }
      end
    end
  end
end
