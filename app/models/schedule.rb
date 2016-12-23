class Schedule < ApplicationRecord
  belongs_to :championship
  belongs_to :location
  has_many :races
  has_many :results, through: :races
  accepts_nested_attributes_for :races, :allow_destroy => true
  accepts_nested_attributes_for :results, :allow_destroy => true

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
