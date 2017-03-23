Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/resultados/(:schedule_number)', to: 'results#index', as: :results

  get '/fechas', to: 'schedules#index', as: :schedules
end
