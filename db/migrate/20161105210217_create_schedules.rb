class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.integer :number, null: false
      t.date :date, null: false
      t.time :start_time
      t.text :description
      t.references :location, null: false
      t.references :championship, null: false

      t.timestamps
    end

    add_index :schedules, :date
  end
end
