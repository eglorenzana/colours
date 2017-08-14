class PhysicalColorSerializer < ActiveModel::Serializer
  attributes :id, :name, :component_l, :component_a, :component_b, :link
  
  def link
    Rails.application.routes.url_helpers.color_url(id: object.id, only_path: true)
  end
end
