class SchedulesController < ApplicationController

  def index
    @championship = Championship.current.first
    @schedules = Schedule.current_championship
    @next_schedule = Schedule.next
  end
end
