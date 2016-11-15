ActiveAdmin.register Race do
  permit_params :kms, :lasts, :category_id

  index do
    selectable_column
    column :kms
    column :lasts
    column :category
    actions
  end

  filter :kms
  filter :lasts
  filter :category
  filter :schedule

end
