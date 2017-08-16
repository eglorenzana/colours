class CreatePcTintParts < ActiveRecord::Migration[5.1]
  def change
    create_table :pc_tint_parts do |t|
      t.references :physical_color, foreign_key: true, index: true
      t.references :tint, foreign_key: true, index: true
      t.integer :percentage, default: 0
      t.timestamps
    end
  end
end
