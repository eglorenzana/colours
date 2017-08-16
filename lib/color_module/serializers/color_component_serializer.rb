module ColorModule
  module Serializers
    # Serializer for color model components
    class ColorComponentSerializer < ActiveModel::Serializer
      attributes :name, :value, :min_value, :max_value
    end
  end
end
