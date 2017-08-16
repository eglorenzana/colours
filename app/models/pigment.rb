# Manage the connection to database for Pigment, and its operations
class Pigment < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  include PhysicalColorPart
end
