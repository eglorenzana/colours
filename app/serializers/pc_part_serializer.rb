class PcPartSerializer < ActiveModel::Serializer
  attributes :percentage
  belongs_to :another_color
  belongs_to :physical_color, unless: ->(obj){obj.instance_options[:skip_color_assoc]}
end
