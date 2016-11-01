class Category < ApplicationRecord
  has_and_belongs_to_many :subcategories, join_table: 'categories_subcategories'

  def to_s
    "#{self.name}"
  end
end
