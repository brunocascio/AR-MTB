class Race < ApplicationRecord
  belongs_to :schedule, required: true
  belongs_to :category, required: true
  has_many :results
  accepts_nested_attributes_for :results, :allow_destroy => true

  ##############################################################################
  # Validations
  ##############################################################################

  validates :kms,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 1
    }

  validates :lasts,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }

  validates :time_trial,
    inclusion: { in: [ true, false] }

  ##############################################################################
  # Helpers
  ##############################################################################

  def as_json(options={})
    super({include: [:category]})
  end

  def to_s
    "[#{category}] [Fecha: #{schedule.number}] [#{schedule.championship.name}]"
  end

  def championship
    schedule.championship
  end
end
