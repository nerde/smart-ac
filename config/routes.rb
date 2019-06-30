Rails.application.routes.draw do
  root to: 'home#index'

  resources :devices, only: %i[create index show]
  resources :device_snapshots, only: :create
  resources :issues, only: %i[index show destroy]
  resources :users, only: :index do
    put :lock, on: :member
    put :unlock, on: :member
  end

  devise_for :users
end
