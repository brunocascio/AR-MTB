module ResultHelper
  def self.parse_json(json)
    results = []
    json.each do |obj|
      @participant = Participant.find(obj[:participant_id])
      @race = Race.find(obj[:race_id])
      results << {
        participant_id: @participant.id,
        race_id: @race.id,
        category_id: @participant.category.id,
        subcategory_id: @participant.subcategory.id,
        participant_number: obj[:participant_number],
        time: DateTime.parse(obj[:time]).strftime("%H:%M:%S"),
      }
    end
    self.calculate_pos(results)
  end

  def self.calculate_pos(r)
    (r.sort_by! {|r| r[:time]}).each_with_index {|r, i| r[:position] = i + 1}
  end
end
