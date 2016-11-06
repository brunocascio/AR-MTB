class Race < ApplicationRecord
  belongs_to :schedule
  belongs_to :category
end
