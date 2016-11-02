ActiveAdmin.register Subcategory do
  menu parent: 'Categories'

  permit_params :name,
    :age_start,
    :age_end,
    :genre,
    category_ids: []

  index do
    selectable_column
    column :name
    column :genre
    column :age_end_formated
    column :age_start_formated
    column :categories_formated
    actions
  end

  form do |f|
    f.inputs "Category Details" do
      f.input :name
      f.input :age_start
      f.input :age_end
      f.input :genre
      f.input :categories, as: :check_boxes
    end
    f.actions
  end

end
