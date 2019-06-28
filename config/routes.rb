Rails.application.routes.draw do
  resources :devices, only: :create, defaults: { format: :json }
  resources :device_snapshots, only: :create, defaults: { format: :json }
end
