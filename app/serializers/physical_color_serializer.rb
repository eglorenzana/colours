class PhysicalColorSerializer < ActiveModel::Serializer
  attributes :id, :name, :space, :link
  def space
    c = ColorModule::Color.new(:LAB, object.components)
    ColorModule::Serializers::ColorModelSerializer.new(c.model, instance_options)
  end
  def link
    Rails.application.routes.url_helpers.color_url(id: object.id, only_path: true)
  end
end
