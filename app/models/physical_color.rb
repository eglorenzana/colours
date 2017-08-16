# Manage the connection to database for PhysicalColor, and its operations
class PhysicalColor < ApplicationRecord
  include PhysicalColorPart
  extend Partitionable

  MIN = LMIN = AMIN =  BMIN = -150
  MAX = LMAX = AMAX =  BMAX = 150

  has_many :white_base_parts, class_name: 'PcWhiteBasePart'
  has_many :pigment_parts, class_name: 'PcPigmentPart'
  has_many :tint_parts, class_name: 'PcTintPart'
  has_many :another_color_parts, class_name: 'PcPart'
  validates :component_l, :component_a, :component_b,
            presence: true,
            uniqueness: { scope: %i[component_l component_a component_b] },
            numericality: { greater_or_equal_to: MIN, less_than_or_equal_to: MAX }
  validates :name,
            uniqueness: { allow_blank: true },
            presence: { unless: ->(obj) { obj.parts.empty? } }
  validates_associated :white_base_parts, :pigment_parts, :tint_parts
  validates_associated :another_color_parts
  validate :reached_percentage, unless: ->(obj) { obj.parts.empty? }

  define_parts :white_base_parts, :pigment_parts, :tint_parts,
               :another_color_parts

  def reached_percentage
    total = part_managers.total_percentage
    if total == 100
      true
    else
      errors.add(:parts, "The sum of all parts does not\
        reach 100 (it is actually #{total})")
    end
  end

  def components
    [component_l, component_a, component_b]
  end

  def components_in_hash
    { component_l: component_l,
      component_a: component_a,
      component_b: component_b }
  end

  def self.active_model_serializer(options = {})
    s = super
    options[:mixture] ? MixtureSerializer : s
  end
end
