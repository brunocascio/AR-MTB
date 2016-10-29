ActiveAdmin.register Location do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs "Location Details" do
      f.input :name
    end
    f.actions
  end

end
