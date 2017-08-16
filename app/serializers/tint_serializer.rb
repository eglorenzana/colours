class TintSerializer < ActiveModel::Serializer
  attributes :name, :type, :concentration, :link
  def link
    Rails.application.routes.url_helpers.tint_url(id: object.id, only_path: true)
  end  
end
