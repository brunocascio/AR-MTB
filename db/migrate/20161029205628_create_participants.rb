class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.integer :genre, null: false
      t.date :birthdate, null: false
      t.string :identification_number, null: false
      t.integer :identification_type, null: false
      t.belongs_to :location, foreign_key: true, null: false
      t.belongs_to :category, foreign_key: true, null: false

      t.timestamps
    end
    add_index :participants, :firstname
    add_index :participants, :lastname
    add_index :participants,
      [:identification_number, :identification_type],
      unique: true,
      name: 'id_number_and_type_index'
  end
end
