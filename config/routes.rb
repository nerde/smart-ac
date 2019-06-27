Rails.application.routes.draw do
  resources :devices, defaults: { format: :json }
end
