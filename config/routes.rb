Rails.application.routes.draw do
  get 'index', to: 'welcome#index'
  root 'tasks#index'
  patch '/', to: 'sessions#update', as: :user
  get 'users/:user_id/tasks', to: 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session
  resources :tasks
end
