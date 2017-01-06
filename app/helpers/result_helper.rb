module ResultHelper

  def self.validate_results!(json)
    results = []
    json.each do |obj|
      raise "Campo 'participante' es requerido." if obj[:participant_id].nil?
      raise "Campo 'tiempo' es requerido." if obj[:time].nil?
      raise "Campo 'carrera' es requerido." if obj[:race_id].nil?
      raise "Campo 'numero' es requerido." if obj[:participant_number].nil?
      @race = Race.find(obj[:race_id])
      @p = @race.schedule.championship.participants.find(obj[:participant_id])
      results << {
        participant_id: @p.id,
        race_id: @race.id,
        category_id: @p.category.id,
        subcategory_id: @p.subcategory.id,
        participant_number: obj[:participant_number],
        position: obj[:position] || nil,
        time: DateTime.parse(obj[:time]).strftime("%H:%M:%S"),
      }
    end
    results
  end
end
