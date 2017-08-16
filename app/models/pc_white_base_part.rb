class PcWhiteBasePart < ApplicationRecord
  belongs_to :physical_color
  belongs_to :white_base
  validates  :physical_color, presence: true    
  validates :white_base, presence: true
  validates :percentage,  numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
end
