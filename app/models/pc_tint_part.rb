class PcTintPart < ApplicationRecord
  belongs_to :physical_color
  belongs_to :tint
  validates  :physical_color, presence: true    
  validates :tint, presence: true  
  validates :percentage,  numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  
  include PhysicalColorPart
  
end
