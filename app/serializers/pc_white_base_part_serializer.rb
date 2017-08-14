class PcWhiteBasePartSerializer < ActiveModel::Serializer
  attributes :percentage
  belongs_to :white_base
  belongs_to :physical_color
end
