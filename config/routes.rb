Rails.application.routes.draw do
  root to: 'goods#index'

  resources :users
  resources :goods
  post '/bulk-upload', to: 'goods#bulk_upload'

  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
