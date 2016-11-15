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
    tabs do
      tab t('app.global.details') do
        f.inputs do
          f.input :name
          f.input :year
          f.input :description
        end
      end
      tab t('activerecord.models.schedule.other') do
        f.inputs do
          f.has_many :schedules, allow_destroy: true do |s|
            s.input :number
            s.input :date, as: :datepicker
            s.input :start_time
            s.input :location, as: :select2
            s.input :description
            s.has_many :races, allow_destroy: true, class: 'form-inline cols3 box' do |r|
              r.input :category, as: :select2, wrapper_html: { class: 'inline'}
              r.input :lasts, wrapper_html: { class: 'inline'}
              r.input :kms, wrapper_html: { class: 'inline'}
            end
          end
        end
      end
      tab t('activerecord.models.participant.other') do
        f.inputs do
          f.input :participants, :input_html => { "data-multi-select" => true }
        end
      end
    end
    f.actions
  end

  show title: :year_with_name do
    tabs do
      tab t('activerecord.models.schedule.other') do
        table_for championship.schedules do
          column :number
          column :date
          column :start_time_formated
          column :location
          column :description
        end
      end
      tab t('activerecord.models.participant.other') do
        table_for championship.participants do
          column(:full_name) { |p| link_to p.full_name }
          column :subcategory_formated
        end
      end
      tab t('activerecord.attributes.championship.description') do
        div do
          simple_format "#{championship.description}"
        end
      end
    end
  end

end
