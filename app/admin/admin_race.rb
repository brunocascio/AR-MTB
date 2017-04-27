ActiveAdmin.register Race do
  menu false
  belongs_to :schedule, optional: true
end
