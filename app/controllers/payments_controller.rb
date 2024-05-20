class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: %i[show update destroy]

  def index
    @payments = current_user.payments
    render json: @payments
  end

  def show
    render json: @payment
  end

  def create
    @payment = current_user.payments.build(payment_params)

    if @payment.save
      render json: @payment, status: :created, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @payment.destroy
    render json: { message: 'Payment successfully deleted' }, status: :ok
  end

  private

  def set_payment
    @payment = current_user.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(
      :user_id,
      :item_ids,
      :total_amount,
      :payment_status,
      :checkout_session_id
    )
  end
end
