ActiveAdmin.register Race, as: "Results" do
  menu parent: 'Championships'
  belongs_to :race

  config.batch_actions = false

  config.filters = false

  config.clear_action_items!

  index do
    column :championship
    column :schedule do |race|
      "#{race.schedule.number}"
    end
    column :category
    actions do |race|
      link_to "asas", new_admin_race_result_path(race.id)
    end
  end
end
