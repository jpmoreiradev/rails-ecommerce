class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order = current_user.orders.includes(order_items: :product).find_by(status: "pending")
  end

  def checkout
    @order = current_user.orders.find_by(status: "pending")

    if @order.nil? || @order.order_items.empty?
      redirect_to orders_path, alert: "Seu carrinho está vazio."
      return
    end

    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

    line_items = @order.order_items.map do |item|
      {
        price_data: {
          currency: "brl",
          product_data: {
            name: item.product.title
          },
          unit_amount: item.unit_price_cents
        },
        quantity: item.quantity
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: line_items,
      mode: "payment",
      success_url: payment_status_orders_url(success: true),
      cancel_url: payment_status_orders_url(canceled: true)
    )

    @order.update(stripe_checkout_session_id: session.id)

    redirect_to session.url, allow_other_host: true
  end

  def payment_status
    @order = current_user.orders.find_by(status: "pending")

    if params[:success]
      @order.update(status: "paid") if @order
      flash[:notice] = "Pagamento realizado com sucesso!"
    elsif params[:canceled]
      flash[:alert] = "Pagamento cancelado."
    end

    redirect_to orders_path
  end
end
