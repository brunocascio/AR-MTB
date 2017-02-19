class Category < ApplicationRecord
  has_and_belongs_to_many :subcategories
  has_many :races

  ##############################################################################
  # Validations
  ##############################################################################

  validates :name,
    presence: true,
    uniqueness: true

  def to_s
    "#{self.name}"
  end
end
