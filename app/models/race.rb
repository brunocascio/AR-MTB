class Race < ApplicationRecord
  belongs_to :schedule
  belongs_to :category
  has_many :results
  accepts_nested_attributes_for :results, :allow_destroy => true

  def to_s
    "[#{category}] [Fecha: #{schedule.number}] [#{schedule.championship.name}]"
  end

  def championship
    schedule.championship
  end
end
