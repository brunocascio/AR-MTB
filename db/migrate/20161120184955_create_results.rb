class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.time :time, null: false
      t.boolean :finished, null: false, default: true
      t.integer :position, null: true, default: nil
      t.string :participant_number, null: false
      t.references :participant, foreign_key: true, null: false, index: true
      t.references :category, foreign_key: true, null: false, index: true
      t.references :subcategory, foreign_key: true, null: false, index: true
      t.references :race, foreign_key: true, null: false, index: true

      t.timestamps
    end
    add_index :results, [:participant_id, :race_id], unique: true
  end
end
