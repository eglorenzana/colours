class WhiteBaseSerializer < ActiveModel::Serializer
  attributes :name, :link
  def link
    Rails.application.routes.url_helpers.white_basis_url(id: object.id, only_path: true)
  end  
end
