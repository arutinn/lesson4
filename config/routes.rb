Rails.application.routes.draw do
  get 'index', to: 'welcome#index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
end