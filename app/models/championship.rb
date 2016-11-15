class Championship < ApplicationRecord
  has_and_belongs_to_many :participants
  has_many :schedules
  accepts_nested_attributes_for :schedules, :allow_destroy => true

  def participants_count
    participants.count
  end

  def year_with_name
    "[#{year}] #{name}"
  end
end
