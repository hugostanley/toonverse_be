class WebhooksController < ApplicationController
  def create
    body = JSON.parse(request.body.read)

    case body['data']['attributes']['type']
    when 'checkout_session.payment.paid'
      handle_checkout_session(body['data']['attributes']['data'])
    else
      Rails.logger.info("Unhandled event type: #{event['type']}")
    end

    head :ok
  end

  private

  def handle_checkout_session(attributes)
    p "CHECKOUT_URL: #{attributes['attributes']['checkout_url']}"
    p "LINE ITEMS: #{attributes['attributes']['line_items']}"
  end
end
