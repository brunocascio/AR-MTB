class Result < ApplicationRecord
  belongs_to :participant
  belongs_to :category
  belongs_to :subcategory
  belongs_to :race

  def self.sync(results)
    Result.transaction do
      results.each do |r|
        Result.find_or_initialize_by(
          participant_id: r[:participant_id],
          race_id: r[:race_id]
        ).update(r)
      end
    end
  end
end
