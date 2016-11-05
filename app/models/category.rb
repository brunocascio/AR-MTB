class Category < ApplicationRecord
  has_and_belongs_to_many :subcategories

  def to_s
    "#{self.name}"
  end
end
