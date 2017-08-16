class PcWhiteBasePartSerializer < ActiveModel::Serializer
  attributes :percentage
  belongs_to :white_base
  belongs_to :physical_color, unless: ->(obj){obj.instance_options[:skip_color_assoc]}
end
