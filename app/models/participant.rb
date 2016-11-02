class Participant < ApplicationRecord
  enum identification_type: [:DNI, :LE, :LC]
  enum genre: [:f, :m]
  belongs_to :location
  belongs_to :category

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

  def subcategory
    Subcategory
      .with_category(category)
      .where(genre: genre)
      .where("? >= age_start", age)
      .where("? <= age_end", age)
      .first
  end
end
