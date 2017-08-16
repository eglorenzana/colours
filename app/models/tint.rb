class Tint < ApplicationRecord
  validates :name, presence: true , uniqueness: true
  include PhysicalColorPart  
end
