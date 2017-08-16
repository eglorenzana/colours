# Manage the connection to database for WhiteBase, and its operations
class WhiteBase < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  include PhysicalColorPart
end
