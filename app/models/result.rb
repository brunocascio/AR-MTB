class Result < ApplicationRecord
  belongs_to :participant, required: true
  belongs_to :category, required: true
  belongs_to :subcategory, required: true
  belongs_to :race, required: true

  ##############################################################################
  # Validations
  ##############################################################################

  validates :participant,
    presence: true,
    uniqueness: {
      scope: :race,
      message: 'Este participant ya se encuentra asociado a la carrera'
    }

  validates :category,
    presence: true

  validates :subcategory,
    presence: true

  validates :race,
    presence: true

  validates :time,
    if: :ran_and_finished?,
    presence: {
      strict: true
    }

  validates :position,
    if: :ran_and_finished?,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }

  validates :participant_number,
    unless: :absent?,
    presence: { strict: true },
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }

  validate :absent_finish_validation

  def absent_finish_validation
    if self.absent? && self.finished?
      errors.add(:finished, "No es posible finalizar estando ausente.")
    end
  end

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

  ##############################################################################
  # JSON Response fields
  ##############################################################################

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

  ##############################################################################
  # Helpers
  ##############################################################################

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
    position = 0
    ordered = results.reject { |r| r.time.nil? }.sort_by(&:time)
    ordered += results.select { |r| r.time.nil? }
    ordered.each_with_index do |r, i|
      if r.finished?
        position += 1
        r.position = position
      else
        r.position = nil
      end
    end
  end

  def ran_and_finished?
    !self.absent? && self.finished?
  end
end
