module ResultHelper

  def self.parse_results!(json)
    results = []
    json.each do |obj|
      @race = Race.find(obj[:race_id])
      @p = @race.schedule.championship.participants.find(obj[:participant_id])
      results << {
        participant_id: @p.id,
        race_id: @race.id,
        category_id: @p.category.id,
        subcategory_id: @p.subcategory.id,
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
