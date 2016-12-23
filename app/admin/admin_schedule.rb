ActiveAdmin.register Schedule do
  menu parent: 'Championships'

  permit_params :number,
    :date,
    :start_time,
    :description,
    :location_id,
    :championship_id,
    races_attributes: [:id, :kms, :lasts, :category_id, :_destroy]

  index do
    selectable_column
    column :championship
    column :number
    column :date
    column :start_time_formated
    column :location
    actions
  end

  form do |f|
    tabs do
      tab t('app.global.details') do
        f.inputs do
          f.input :number
          f.input :date
          f.input :start_time
          f.input :location, as: :select2
          f.input :championship, as: :select2
          f.input :description
        end
      end
      tab t('activerecord.models.race.other') do
        f.inputs do
          f.has_many :races,
          heading: false,
          allow_destroy: true,
          class: 'form-inline cols3' do |a|
            a.input :category, as: :select2, wrapper_html: {class: 'inline'}
            a.input :kms, wrapper_html: {class: 'inline'}
            a.input :lasts, wrapper_html: {class: 'inline'}
          end
        end
      end
    end
    f.actions
  end

end
