class Participant < ApplicationRecord
  enum identification_type: [:DNI, :LE, :LC]
  belongs_to :location

  def full_name
    "#{firstname} #{lastname}"
  end

  def identification
    "#{identification_number} (#{identification_type})"
  end

  def age
    age = Date.today.year - birthdate.year
    # for days before birthday
    age -= 1 if Date.today < birthdate + age.years
    age.to_i
  end

  def age_formated
    "#{age} años"
  end
end
