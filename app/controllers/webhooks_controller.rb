# Install ngrok -> https://dashboard.ngrok.com/get-started/setup/linux
# expose the localhost:3000 by running this command `ngrok http http://localhost:3000`
# go to ngrok endpoints -> get the url then open a webhook connection to paymongo https://developers.paymongo.com/reference/create-a-webhook
# insert the ngrok url + /webhook/paymongo to the paymongo webhook url
class WebhooksController < ApplicationController
  def create
    body = JSON.parse(request.body.read)

    case body['data']['attributes']['type']
    when 'checkout_session.payment.paid'
      handle_checkout_session(body['data']['attributes']['data'])
    else
      Rails.logger.info("Unhandled event type: #{event['type']}")
    end
    # Need to return 200 according to paymongo docs
    head :ok
  end

  private

  def handle_checkout_session(attributes)
    p "CHECKOUT_URL: #{attributes['attributes']['checkout_url']}"
    p "LINE ITEMS: #{attributes['attributes']['line_items']}"

    # TODO
    # insert logic here to write to DB payment status/id etc
    # insert payment.update
    # insert order.create
  end
end
