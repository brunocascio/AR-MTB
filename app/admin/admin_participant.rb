ActiveAdmin.register Participant do
  menu priority: 3

  permit_params :firstname,
    :lastname,
    :location_id,
    :category_id,
    :birthdate,
    :genre,
    :identification_type,
    :identification_number

  index do
    selectable_column
    column :full_name
    column :age_formated
    column :location
    column :subcategory_formated
    column :enrolled_championships
    actions
  end

  form do |f|
    f.inputs t("activerecord.models.participant.one") do
      f.input :firstname
      f.input :lastname
      f.input :genre, as: :select2
      f.input :birthdate,
        start_year: Date.today.year - 100,
        end_year: Date.today.year - 14
      f.input :identification_type, as: :select2
      f.input :identification_number
      f.input :location, as: :select2
      f.input :category, as: :select2
    end
    f.actions
  end

end
