class PcPigmentPartSerializer < ActiveModel::Serializer
  attributes :percentage
  belongs_to :pigment
  belongs_to :physical_color
end
