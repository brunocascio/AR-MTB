class Participant < ApplicationRecord
  enum identification_type: [:DNI, :LE, :LC]
  enum genre: [:f, :m]
  has_and_belongs_to_many :championships
  belongs_to :location
  belongs_to :category

  def as_json(options={})
    super({
      include: {
        subcategory: {only: [ :name, :id ]},
        category: {only: [ :name, :id ]}
      },
      only: [ :firstname, :lastname, :id ]
    })
  end

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
    Subcategory.with_category(category).with_genre(genre).in_age(age).first
  end

  def subcategory_formated
    "#{subcategory} (#{category})"
  end

  def enrolled_championships
    championships.count
  end

  def to_s
    "#{full_name} (#{identification})"
  end

  def self.with_category(category)
    where(category: category)
  end
end
