class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = ENV["STRIPE_WEBHOOK_SECRET"]

    event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)

    case event["type"]
    when "payment_intent.succeeded"
      pi = event["data"]["object"]
      order_id = pi["metadata"]["order_id"]
      order = Order.find_by(id: order_id)
      order.update!(status: "paid") if order
    end

    head :ok
  end
end
