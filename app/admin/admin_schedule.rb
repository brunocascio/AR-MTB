ActiveAdmin.register Schedule do
  menu parent: 'Championships'

  permit_params :number,
    :date,
    :start_time,
    :location_id,
    :championship_id

  index do
    selectable_column
    column :championship
    column "Date Number", :number
    column :date
    column "Start Time", :start_time_formated
    column :location
    actions
  end

end
