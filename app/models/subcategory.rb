class Subcategory < ApplicationRecord
  enum genre: [:f, :m]
  has_and_belongs_to_many :categories, join_table: 'categories_subcategories'

  def self.with_category(category)
    joins("join categories_subcategories on subcategories.id = categories_subcategories.subcategory_id")
    .where(["categories_subcategories.category_id = ?", category])
  end

  def categories_formated
    categories.join(', ').titleize
  end

  def age_start_formated
    "#{Date.today.year - age_start} (#{age_start})"
  end

  def age_end_formated
    "#{Date.today.year - age_end} (#{age_end})"
  end
end
