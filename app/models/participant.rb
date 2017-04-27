class Participant < ApplicationRecord
  enum identification_type: [:DNI, :LE, :LC]
  enum genre: [:f, :m]
  has_and_belongs_to_many :championships
  belongs_to :location, required: true
  belongs_to :category, required: true

  ##############################################################################
  # Validations
  ##############################################################################

  validates :firstname, :lastname,
   presence: true,
   format: { with: /\A[\p{L}\s.]+\z/ },
   length: { minimum: 2, maximum: 30 }

  validates :genre,
    inclusion: { in: genres.keys }

  validates :birthdate,
    presence: true,
    date: {
      after: Proc.new { Time.now - 100.year },
      before: Proc.new { Time.now - 14.year }
    }

  validates :identification_number,
    presence: true,
    uniqueness: { scope: :identification_type },
    numericality: { only_integer: true },
    format: { with: /\A[0-9]+\z/ },
    length: { minimum: 6, maximum: 8 }

  validates :identification_type,
    inclusion: { in: identification_types.keys }

  ##############################################################################
  # Helpers
  ##############################################################################

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
