class Schedule < ApplicationRecord
  belongs_to :championship, required: true
  belongs_to :location, required: true
  has_many :races
  has_many :results, through: :races
  accepts_nested_attributes_for :races, :allow_destroy => true
  accepts_nested_attributes_for :results, :allow_destroy => true

  ##############################################################################
  # Validations
  ##############################################################################

  validates :number,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }

  validates :date,
    presence: true,
    date: true

  validates_time :start_time

  ##############################################################################
  # Helpers
  ##############################################################################

  def start_time_formated
    start_time.strftime("%H:%M")
  end

  def is_old
    date <= Date.today
  end

  def to_s
    "#{number} => (#{championship.name.truncate 30})"
  end

  def with_participants(category)
    championship.participants.with_category(category)
  end
end
