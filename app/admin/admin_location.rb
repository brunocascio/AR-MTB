ActiveAdmin.register Location do
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs t('activerecord.models.location.one') do
      f.input :name
    end
    f.actions
  end

end
