# Manage the connection to database for WhiteBase association with PhysicalColor
class PcWhiteBasePart < ApplicationRecord
  belongs_to :physical_color
  belongs_to :white_base
  validates :percentage,
            numericality:
            { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  validates_associated :white_base
end
