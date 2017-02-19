class Subcategory < ApplicationRecord
  enum genre: [:f, :m]
  has_and_belongs_to_many :categories

  ##############################################################################
  # Validations
  ##############################################################################

  validates :name,
    presence: true,
    uniqueness: {
      scope: :genre,
      message: 'Esta categoría ya existe.'
    }

  validates :genre,
    inclusion: { in: genres.keys }

  validates :age_start,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 14,
      less_than: ->(record) { record.age_end || 100 }
    }

  validates :age_end,
    presence: true,
    numericality: {
      only_integer: true,
      less_than_or_equal_to: 100,
      greater_than: ->(record) { record.age_start || 14 }
    }

  ##############################################################################
  # Helpers
  ##############################################################################

  def categories_formated
    categories.join(', ').titleize
  end

  def age_start_formated
    "#{Date.today.year - age_start} (#{age_start})"
  end

  def age_end_formated
    "#{Date.today.year - age_end} (#{age_end})"
  end

  def to_s
    name
  end

  # Scopes

  def self.with_category(category)
    joins("join categories_subcategories on subcategories.id = categories_subcategories.subcategory_id")
    .where(["categories_subcategories.category_id = ?", category])
  end

  def self.in_age(age)
    where("? >= age_start", age)
    .where("? <= age_end", age)
  end

  def self.with_genre(genre)
    where(genre: genre)
  end
end
