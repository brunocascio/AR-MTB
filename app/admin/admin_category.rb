ActiveAdmin.register Category do
  menu priority: 4

  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  filter :name
end
