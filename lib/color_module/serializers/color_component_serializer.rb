module ColorModule
  module Serializers
    class ColorComponentSerializer < ActiveModel::Serializer
      attributes :name, :value, :min_value, :max_value
    end
  end
end
