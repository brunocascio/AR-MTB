class Schedule < ApplicationRecord
  belongs_to :championship
  belongs_to :location
  has_many :races
  accepts_nested_attributes_for :races, :allow_destroy => true

  def start_time_formated
    start_time.strftime("%H:%M")
  end

  def to_s
    "#{number} => (#{championship.name.truncate 30})"
  end
end
