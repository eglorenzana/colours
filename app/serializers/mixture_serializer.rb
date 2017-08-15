class MixtureSerializer < ActiveModel::Serializer
  attributes :name, :space, :parts
  
  def space
    c = ColorModule::Color.new(:LAB, object.components)
    ColorModule::Serializers::ColorModelSerializer.new(c.model, instance_options)
  end
  
  def parts
    object.recipe.map do |part, percentage|
      s =  part.active_model_serializer
      s.new(part, instance_options)
    end
  end
  
  def link
    Rails.application.routes.url_helpers.mixture_url(id: object.id, only_path: true)
  end
end
