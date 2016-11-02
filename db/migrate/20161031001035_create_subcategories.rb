class CreateSubcategories < ActiveRecord::Migration[5.0]
  def change
    create_table :subcategories do |t|
      t.string :name, null: false
      t.integer :age_start, null: false
      t.integer :age_end, null: false
      t.integer :genre, null: false

      t.timestamps
    end
    add_index :subcategories, :name, unique: true
  end
end
