# Manage the connection to database for Tint association with PhysicalColor
class PcTintPart < ApplicationRecord
  belongs_to :physical_color
  belongs_to :tint
  validates :percentage,
            numericality:
            { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  validates_associated :tint
end
