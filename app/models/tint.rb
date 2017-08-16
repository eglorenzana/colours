# Manage the connection to database for Tint, and its operations
class Tint < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  include PhysicalColorPart
end
