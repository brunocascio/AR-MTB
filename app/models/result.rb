class Result < ApplicationRecord
  belongs_to :participant
  belongs_to :category
  belongs_to :subcategory
  belongs_to :race

  before_validation do
    self.participant = Participant.find(self.participant_id)
    self.category_id = self.participant.category.id
    self.subcategory_id = self.participant.subcategory.id
    if self.absent?
      self.time = nil
      self.participant_number = nil
    end
    if self.absent? || !self.finished?
      self.time = nil
      self.position = nil
    end
  end

  def as_json(options={})
    time_parse = Time.parse(time.to_s).strftime('%H:%M:%S') unless time.nil?
    super({
      include: {
        participant: {only: [ :firstname, :lastname, :id ]},
        subcategory: {only: [ :name, :id ]},
        category: {only: [ :name, :id ]}
      },
      except: [:updated_at, :category_id, :subcategory_id, :participant_id]
    }).merge({
      time: time_parse
    })
  end

  def self.sync(results)
    results = self.set_positions(results)
    Result.transaction do
      results.each do |r|
        Result.find_or_initialize_by(
          participant_id: r.participant_id,
          race_id: r.race_id
        ).update(r.attributes.except("id", "created_at", "updated_at"))
      end
    end
    results
  end

  def self.set_positions(results)
    ordered = results.reject { |r| r.time.nil? }.sort_by(&:time) + results.select { |r| r.time.nil? }
    ordered.each_with_index do |r, i|
      if r.finished?
        r.position = i + 1
      end
    end
  end
end
