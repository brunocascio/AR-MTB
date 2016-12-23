class Result < ApplicationRecord
  belongs_to :participant
  belongs_to :category
  belongs_to :subcategory
  belongs_to :race
end
