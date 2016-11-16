ActiveAdmin.register Schedule do
  menu false
  
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
    f.inputs "Schedule Details" do
      f.input :number
      f.input :date
      f.input :start_time
      f.input :location, as: :select2
      f.input :championship, as: :select2
      f.input :description
      f.has_many :races, new_record: "Add", allow_destroy: true do |a|
        a.input :kms
        a.input :lasts
        a.input :category, as: :select2
      end
    end
    f.actions
  end

end
