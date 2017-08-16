class CreatePigments < ActiveRecord::Migration[5.1]
  def change
    create_table :pigments do |t|
      t.string :name, limit: 40
      t.string :type, limit: 30
      t.integer :concentration
      t.boolean :active, default: true      
      t.timestamps
    end
  end
end
