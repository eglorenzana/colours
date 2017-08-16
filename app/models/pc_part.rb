class PcPart < ApplicationRecord
  belongs_to :physical_color
  belongs_to :another_color, class_name: 'PhysicalColor', foreign_key: 'another_color_id'
  validates  :physical_color, presence: true    
  validates :another_color, presence: true
  validates :percentage,  numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
end
