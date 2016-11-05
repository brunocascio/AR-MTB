ActiveAdmin.register Championship do
  permit_params :name,
    :year,
    :description,
    participant_ids: []


  index do
    selectable_column
    column :year
    column :name do |post|
      truncate(post.name, omision: "...", length: 50)
    end
    column :description do |post|
      truncate(post.description, omision: "...", length: 50)
    end
    column :participants_count
    actions
  end

  filter :name
  filter :year
  filter :description

  form do |f|
    f.inputs "Championship Details" do
      f.input :name
      f.input :year
      f.input :description
      f.input :participants
    end
    f.actions
  end

end
