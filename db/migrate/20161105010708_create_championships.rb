class CreateChampionships < ActiveRecord::Migration[5.0]
  def change
    create_table :championships do |t|
      t.string :name, null: false
      t.integer :year, null: false
      t.text :description

      t.timestamps
    end
    add_index :championships, [:name, :year], unique: true
  end
end
