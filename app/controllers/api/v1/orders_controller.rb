class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!, unless: :workforce_signed_in?
  before_action :authenticate_workforce!, unless: :user_signed_in?
  before_action :set_order, only: %i[show update]
  before_action :authorize_admin!, only: :destroy

  def index
    if @current_user
      @orders = @current_user.orders.order(created_at: :desc).includes(:item)
      render json: @orders.to_json(include: :item)
    else
      @orders = Order.all.order(:created_at).includes(:item)
      orders = @orders.map { |order| format_order(order) }
      render json: orders
    end
  end

  def show
    render json: format_order(@order)
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update!(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    render json: { message: 'Order successfully deleted' }, status: :ok
  end

  private

  def set_order
    if @current_user
      @order = current_user.orders.find_by(id: params[:id])
    elsif @current_workforce
      @order = Order.find_by(id: params[:id])
    end

    return if @order

    render json: { error: 'Order not found' }, status: :not_found
  end

  def order_params
    params.require(:order).permit(
      :total_amount,
      :order_status,
      :checkout_session_id,
      :workforce_id,
      item_ids: []
    )
  end

  def format_order(order)
    {
      id: order.id,
      item_id: order.item_id,
      payment_id: order.payment_id,
      amount: order.amount,
      order_status: order.order_status,
      workforce_id: order.workforce_id,
      created_at: order.created_at,
      background_url: order.item&.background_url,
      number_of_heads: order.item&.number_of_heads,
      picture_style: order.item&.picture_style,
      art_style: order.item&.art_style,
      notes: order.item&.notes,
      reference_image: order.item.image.attached? ? url_for(order.item&.image) : nil,
      latest_artwork: order.job&.artworks.present? ? order.job.artworks.last.artwork_url : nil,
      latest_artwork_revision: order.job&.artworks.present? ? order.job.artworks.last.revision_number : nil
    }
  end

  def authorize_admin!
    if @current_workforce && @current_workforce.role != 'admin'
      render json: { error: 'Forbidden' }, status: :forbidden
    elsif !@current_workforce
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
