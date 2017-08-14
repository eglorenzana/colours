class PcTintPartSerializer < ActiveModel::Serializer
  attributes :percentage
  belongs_to :tint
  belongs_to :physical_color
end
