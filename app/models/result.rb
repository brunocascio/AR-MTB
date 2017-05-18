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

  validates :time,
    if: :absent_or_no_finished?,
    absence: { strict: true }

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
  
  validates :participant_number,
    if: :absent?,
    absence: { strict: true }

  validate :absent_finish_validation

  def absent_finish_validation
    if self.absent? && self.finished?
      errors.add(
        :finished, "No es posible finalizar estando ausente o viceversa."
      )
    end
  end

  def ran_and_finished?
    !self.absent? && self.finished?
  end

  def absent_or_no_finished?
    self.absent? || !self.finished?
  end

  before_validation do
    self.participant = Participant.find(self.participant_id)
    self.category_id = self.participant.category.id
    self.subcategory_id = self.participant.subcategory.id
  end

  ##############################################################################
  # JSON Response fields
  ##############################################################################

  def as_json(options={})
    super({
      include: {
        participant: {only: [ :firstname, :lastname, :id ]},
        subcategory: {only: [ :name, :id ]},
        category: {only: [ :name, :id ]}
      },
      except: [:updated_at, :category_id, :subcategory_id, :participant_id]
    }).merge({
      time: human_time
    })
  end

  ##############################################################################
  # Helpers
  ##############################################################################

  def to_s
    participant.firstname
  end

  def human_time
    Time.parse(time.to_s).strftime('%H:%M:%S') unless time.nil?
  end

  def self.sync(results)
    to_ret = self.set_positions(results)
    Result.transaction do
      to_ret.each do |r|
        Result.find_or_initialize_by(
          participant_id: r.participant_id,
          race_id: r.race_id
        ).update!(r.attributes.except("id", "created_at", "updated_at"))
      end
    end
  end

  def self.set_positions(results)
    absents = results.select { |r| r.absent? }
    runners = results.reject { |r| r.absent? }
    finishers = results.select { |r| r.finished? }
    ordered = finishers
      .sort_by(&:time)
      .each_with_index { |r, index| r.position = index+1 }
    ordered = ordered + runners + absents
  end
end
