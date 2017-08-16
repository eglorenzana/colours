class PcPart < ApplicationRecord
  belongs_to :physical_color 
  belongs_to :another_color, class_name: 'PhysicalColor', foreign_key: 'another_color_id'
  validates :percentage,  numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  validates_associated :another_color
  validate :another_color_is_already_stored
  
  def another_color_is_already_stored
    (another_color && another_color.persisted?) ? true : errors.add(:another_color, 'It is not saved yet; It must exist in database to use it')
  end
end
