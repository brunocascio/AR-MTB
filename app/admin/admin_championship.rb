ActiveAdmin.register Championship do
  permit_params :name,
    :year,
    :description,
    participant_ids: [],
    schedules_attributes: [
      :id,
      :number,
      :date,
      :start_time,
      :description,
      :location_id,
      :championship_id,
      :_destroy,
      races_attributes: [:id, :kms, :lasts, :category_id, :_destroy]
    ]

  index do
    selectable_column
    column :year
    column :name do |post|
      truncate(post.name, omision: "...", length: 50)
    end
    column :description do |post|
      truncate(post.description, omision: "...", length: 50)
    end
    column :participants_count
    actions
  end

  filter :name
  filter :year
  filter :description

  form do |f|
    f.inputs "Championship Details" do
      f.input :name
      f.input :year
      f.input :description, :input_html => { rows: 5 }
      f.input :participants, :input_html => { "data-multi-select" => true }
      f.has_many :schedules, allow_destroy: true do |s|
        s.input :number
        s.input :date, as: :datepicker
        s.input :start_time
        s.input :location
        s.input :description, :input_html => { rows: 5 }
        s.has_many :races, allow_destroy: true do |r|
          r.input :kms
          r.input :lasts
          r.input :category
        end
      end
    end
    f.actions
  end

end
