class AddPcPartReferenceToPhysicalColors < ActiveRecord::Migration[5.1]
  def change
    add_reference :pc_parts, :another_color, references: :physical_colors
    add_foreign_key :pc_parts, :physical_colors, column: :another_color_id
  end
end
