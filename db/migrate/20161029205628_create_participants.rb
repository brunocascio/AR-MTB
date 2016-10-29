class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthdate
      t.string :identification_number
      t.integer :identification_type
      t.belongs_to :location, foreign_key: true

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
