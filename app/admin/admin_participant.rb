ActiveAdmin.register Participant do
  permit_params :firstname,
    :lastname,
    :location_id,
    :birthdate,
    :identification_type,
    :identification_number

  index do
    selectable_column
    column :full_name
    column :age_formated
    column :location
    column :identification
    actions
  end

  filter :firstname
  filter :lastname
  filter :birthdate
  filter :location
  filter :identification_number

end
