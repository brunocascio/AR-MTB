ActiveAdmin.register Championship do
  permit_params :name,
    :year,
    :description


  index do
    selectable_column
    column :name
    column :year
    column :description
    actions
  end

  filter :name
  filter :year
  filter :description

  # form do |f|
  #   f.inputs "Category Details" do
  #     f.input :name
  #   end
  #   f.actions
  # end

end
