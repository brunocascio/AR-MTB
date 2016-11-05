class Schedule < ApplicationRecord
  belongs_to :championship
  belongs_to :location

  def start_time_formated
    start_time.strftime("%H:%M")
  end
end
