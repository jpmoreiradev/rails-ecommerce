Rails.application.routes.draw do
  root "products#index"

  devise_for :users
  resources :products, only: [ :index, :show ]
  resources :orders, only: [ :new, :create, :show ]
  post "/checkout", to: "checkouts#create"
  post "/webhooks/stripe", to: "webhooks#stripe"
end
