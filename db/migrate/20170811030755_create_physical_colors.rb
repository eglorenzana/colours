class CreatePhysicalColors < ActiveRecord::Migration[5.1]
  def change
    create_table :physical_colors do |t|
      t.string :name, limit: 40
      t.decimal :component_l, precision: 8, scale: 4
      t.decimal :component_a, precision: 8, scale: 4
      t.decimal :component_b, precision: 8, scale: 4
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
