ActiveAdmin.register Participant do
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
    column :genre
    column :location
    column :category
    column :subcategory
    column :identification
    actions
  end

  filter :firstname
  filter :lastname
  filter :genre
  filter :birthdate
  filter :location
  filter :category
  filter :identification_number

end
