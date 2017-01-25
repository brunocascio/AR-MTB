module ResultHelper

  # TODO: Remove manual validations. Use ActiveRecord validations instead.
  def self.validate_results!(json)
    results = []
    # Processing json
    json.each do |obj|
      # Raising exception with invalid data
      raise "Campo 'participante' es requerido." if obj[:participant_id].blank?
      raise "Campo 'carrera' es requerido." if obj[:race_id].blank?

      # Verify if the object is marked as absent.
      #   If true and exists, will remove it.
      #   else, will insert it.
      if obj.has_key?(:absent) && obj[:absent]
        temp_r = Result.where(participant_id: obj[:participant_id])
          .where(race_id: obj[:race_id])
          .first
        Result.destroy(temp_r.id) unless temp_r.nil?
      else
        raise "Campo 'tiempo' es requerido." if obj[:time].blank?
        raise "Campo 'numero' es requerido." if obj[:participant_number].blank?
        # Found the race
        @race = Race.find(obj[:race_id])

        # Get the current participant involved in the championship
        @p = @race.schedule.championship.participants.find(obj[:participant_id])

        # Add the valid result object
        results << {
          participant_id: @p.id,
          race_id: @race.id,
          category_id: @p.category.id,
          subcategory_id: @p.subcategory.id,
          participant_number: obj[:participant_number],
          position: obj[:position] || nil,
          finished: obj[:finished] || false,
          time: DateTime.parse(obj[:time]).strftime("%H:%M:%S"),
        }
      end
    end
    results
  end
end
