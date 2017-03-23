class Championship < ApplicationRecord
  has_and_belongs_to_many :participants
  has_many :schedules
  # has_many :races
  # has_many :races, through: :schedules
  # has_many :results, through: :races
  accepts_nested_attributes_for :schedules, :allow_destroy => true
  # accepts_nested_attributes_for :races, :allow_destroy => true
  # accepts_nested_attributes_for :results, :allow_destroy => true

  ##############################################################################
  # Validations
  ##############################################################################

  validates :name,
    presence: true,
    uniqueness: {
      scope: :year
    }

  validates :year,
    presence: true,
    uniqueness: true

  ##############################################################################
  # Helpers
  ##############################################################################

  def participants_count
    participants.count
  end

  def year_with_name
    "[#{year}] #{name}"
  end

  ##############################################################################
  # Scopes
  ##############################################################################

  def self.current
    where(year: Date.today.year)
  end

end
