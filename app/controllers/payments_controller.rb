class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: %i[show update destroy]

  # GET /payments
  def index
    @payment = current_user.payment
    render json: @payment
  end

  # GET /payments/1
  def show
    render json: @payment
  end

  # POST /payments
  def create
    @payment = current_user.payment.build(item_params)

    if @payment.save
      render json: @payment, status: :created, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy
  end

  private

  def set_payment
    @payment = current_user.payment.find(params[:id])
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
