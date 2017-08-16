module ColorModule
  module Serializers
    # Serializer for color model
    class ColorModelSerializer < ActiveModel::Serializer
      attributes :model_name, :components

      def components
        if instance_options[:long]
          object.components.map { |c| ColorComponentSerializer.new(c) }
        else
          object.components_to_hash
        end
      end
    end
  end
end
