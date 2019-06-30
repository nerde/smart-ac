Rails.application.routes.draw do
  root to: 'home#index'

  resources :devices, only: %i[create index show]
  resources :device_snapshots, only: :create

  devise_for :users
end
