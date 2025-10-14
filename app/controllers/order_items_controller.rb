class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:id])

    order = current_user.orders.find_by(status: "pending") || current_user.orders.create(status: "pending")

    order_item = order.order_items.find_by(product: product)

    if order_item
      order_item.quantity += 1
      order_item.save
    else
      order.order_items.create(product: product, quantity: 1, unit_price_cents: product.price_cents)
    end

    redirect_to orders_path, notice: "#{product.title} adicionado ao carrinho!"
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    order_item.destroy
    redirect_back fallback_location: orders_path, notice: "Item removido do carrinho."
  end
end
