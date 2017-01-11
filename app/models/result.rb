class Result < ApplicationRecord
  belongs_to :participant
  belongs_to :category
  belongs_to :subcategory
  belongs_to :race

  def as_json(options={})
    super({
      include: {
        participant: {only: [ :firstname, :lastname, :id ]},
        subcategory: {only: [ :name, :id ]},
        category: {only: [ :name, :id ]}
      },
      except: [:updated_at, :category_id, :subcategory_id, :participant_id]
    }).merge({
      time: Time.parse(time.to_s).strftime('%H:%M:%S')
    })
  end

  def self.sync(results)
    results = self.set_positions(results)
    Result.transaction do
      results.each do |r|
        Result.find_or_initialize_by(
          participant_id: r[:participant_id],
          race_id: r[:race_id]
        ).update(r)
      end
    end
  end

  def self.set_positions(r)
    (r.sort_by! {|r| r[:time]}).each_with_index {|r, i| r[:position] = i + 1}
  end
end
