class CreateJoinTableParticipantChampionship < ActiveRecord::Migration[5.0]
  def change
    create_join_table :participants, :championships do |t|
      t.index [:participant_id, :championship_id],
        name: 'index_part_champ_on_part_id_and_champ_id'
    end
  end
end
