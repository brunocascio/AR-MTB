class Championship < ApplicationRecord
  has_and_belongs_to_many :participants

  def participants_count
    participants.count
  end
end
