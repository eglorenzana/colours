class PhysicalColor < ApplicationRecord
  validates :component_l, :component_a, :component_b, presence: true
  has_many :white_base_parts, class_name: 'PcWhiteBasePart'
  has_many :pigment_parts, class_name: 'PcPigmentPart'
  has_many :tint_parts, class_name: 'PcTintPart'
  has_many :another_color_parts, class_name: 'PcPart', foreign_key: 'another_color_id'
  validates :name, uniqueness: true
  include PhysicalColorPart  
  extend Partitionable
  define_parts :white_base_parts, :pigment_parts, :tint_parts, :another_color_parts
  

end