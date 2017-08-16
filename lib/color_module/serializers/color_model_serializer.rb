module ColorModule
  module Serializers
    class ColorModelSerializer < ActiveModel::Serializer
      attributes :model_name, :components

      def components
        instance_options[:long] ? 
          (object.components.map{|c| ColorComponentSerializer.new(c)}) :
          (object.components_to_hash)
      end
    end
  end
end