Rails.application.routes.draw do
  get "orders/index"
  get "orders/show"
  get "orders/checkout"
  # Devise
  devise_for :users

  # Root
  root "products#index"

  # Produtos
  resources :products, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    post "add_to_cart", to: "order_items#create", on: :member
  end


  resources :orders, only: [ :index, :show ] do
    post :checkout, on: :collection
    get :payment_status, on: :collection
    resources :order_items, only: [ :create, :update, :destroy ]
  end




  # Checkout
  get "checkout", to: "orders#checkout"
  get "orders/payment_status", to: "orders#payment_status"
  post "checkout", to: "orders#process_checkout"
end
