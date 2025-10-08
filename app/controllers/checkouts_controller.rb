class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    order = current_user.orders.create!(
      total_cents: product.price_cents * quantity,
      status: "pending"
    )

    order.order_items.create!(
      product: product,
      quantity: quantity,
      unit_price_cents: product.price_cents
    )

    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    payment_intent = Stripe::PaymentIntent.create({
      amount: order.total_cents,
      currency: "brl",
      metadata: { order_id: order.id }
    })

    order.update!(stripe_payment_intent_id: payment_intent.id)

    render json: { client_secret: payment_intent.client_secret, order_id: order.id }
  end
end
