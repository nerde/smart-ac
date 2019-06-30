Rails.application.routes.draw do
  root to: 'home#index'

  resources :devices, only: %i[create index show]
  resources :device_snapshots, only: :create
  resources :issues, only: %i[index show destroy]

  devise_for :users
end
