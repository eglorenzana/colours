class PigmentSerializer < ActiveModel::Serializer
  attributes :name, :type, :concentration, :link
  def link
    Rails.application.routes.url_helpers.pigment_url(id: object.id, only_path: true)
  end  
end
