class Subcategory < ApplicationRecord
  has_and_belongs_to_many :categories, join_table: 'categories_subcategories'

  def categories_formated
    categories.join(', ').titleize
  end
end
