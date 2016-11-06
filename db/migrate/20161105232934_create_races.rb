class CreateRaces < ActiveRecord::Migration[5.0]
  def change
    create_table :races do |t|
      t.integer :kms, null: false
      t.integer :lasts, null: false
      t.references :category, null: false
      t.references :schedule, null: false

      t.timestamps
    end
  end
end
