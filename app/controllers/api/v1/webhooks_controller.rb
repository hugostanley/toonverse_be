# Install ngrok -> https://dashboard.ngrok.com/get-started/setup/linux
# expose the localhost:3000 by running this command `ngrok http http://localhost:3000`
# go to ngrok endpoints -> get the url then open a webhook connection to paymongo https://developers.paymongo.com/reference/create-a-webhook
# insert the ngrok url + /webhook/paymongo to the paymongo webhook url
class Api::V1::WebhooksController < ApplicationController
  def create
    body = JSON.parse(request.body.read)

    case body['data']['attributes']['type']
    when 'checkout_session.payment.paid'
      update_payment_status(body)
    else
      Rails.logger.info("Unhandled transaction type: #{body['data']['attributes']['type']}")
    end
    # Need to return 200 according to paymongo docs
    head :ok
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse webhook body: #{e.message}")
    head :bad_request
  rescue StandardError => e
    Rails.logger.error("Webhook processing error: #{e.message}")
    head :internal_server_error
  end

  private

  def update_payment_status(attributes)
    cd_id = attributes['data']['attributes']['data']['id']
    payment_status = attributes['data']['attributes']['data']['attributes']['payments']['status']

    @payment = Payment.find_by(checkout_session_id: cd_id)

    if @payment && payment_status == 'paid'
      if @payment.update(payment_status: 'paid')
        Rails.logger.info("Payment #{@payment.id} status updated to paid.")
      else
        Rails.logger.error("Failed to update payment status: #{@payment.errors.full_messages.join(', ')}")
      end
    else
      Rails.logger.error("Payment not found for checkout_session_id: #{cd_id}")
    end
  end
end
