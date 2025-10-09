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

  # Pedidos e itens
  resources :orders do
    resources :order_items, only: [ :create, :update, :destroy ]
  end

  # Checkout
  get "checkout", to: "orders#checkout"
  post "checkout", to: "orders#process_checkout"
end
