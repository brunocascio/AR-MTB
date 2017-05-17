ActiveAdmin.register Championship do
  menu priority: 2

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
      races_attributes: [
        :id, 
        :kms, 
        :lasts, 
        :time_trial, 
        :category_id, 
        :_destroy
      ]
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
      tab t('activerecord.models.participant.other') do
        f.inputs do
          f.input :participants, :input_html => { "data-multi-select" => true }
        end
      end
      tab t('activerecord.models.schedule.other') do
        f.inputs do
          f.has_many :schedules, heading: false do |s|
            s.input :number
            s.input :date, as: :datepicker
            s.input :start_time
            s.input :location, as: :select2
            s.input :description
            s.has_many :races, class: 'form-inline cols4 box' do |r|
              r.input :category, as: :select2, wrapper_html: { class: 'inline'}
              r.input :lasts, wrapper_html: { class: 'inline'}
              r.input :kms, wrapper_html: { class: 'inline'}
              r.input :time_trial, wrapper_html: { class: 'inline'}
              r.input :_destroy,
                :as => :boolean,
                :required => false,
                :label => 'Remover Carrera'
            end
            s.input :_destroy,
              :as => :boolean,
              :required => false,
              :label => 'Remover Fecha'
          end
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
          # column do |s|
          #   link_to "Results", admin_schedule_races_path(s.id) if s.is_old
          # end
        end
      end
      tab t('activerecord.models.participant.other') do
        paginated_collection(championship.participants.page(params[:page])) do
          table_for collection do
            column(:full_name) { |p| link_to p.full_name }
            column :subcategory_formated
          end
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
