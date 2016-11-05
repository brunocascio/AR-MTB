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
    column "Name", :full_name
    column "Age", :age_formated
    column :genre
    column :location
    column "Category", :subcategory_formated
    column "Championships", :enrolled_championships
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
