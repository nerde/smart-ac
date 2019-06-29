Rails.application.routes.draw do
  root to: 'home#index'

  resources :devices, only: :create, defaults: { format: :json }
  resources :device_snapshots, only: :create, defaults: { format: :json }

  devise_for :users
end
