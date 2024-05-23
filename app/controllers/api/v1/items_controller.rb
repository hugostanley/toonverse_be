class Api::V1::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[show update destroy]

  # GET /items
  def index
    @items = current_user.items.unpaid_or_pending
    render json: @items.map { |item| item_with_image_url(item) }
  end

  # GET /items/1
  def show
    render json: item_with_image_url(@item)
  end

  # POST /items
  def create
    @item = current_user.items.build(item_params)

    if @item.save
      render json: item_with_image_url(@item), status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: item_with_image_url(@item)
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :user_id,
      :background_url,
      :number_of_heads,
      :art_style,
      :picture_style,
      :notes,
      :image
    )
  end

  def item_with_image_url(item)
    item.as_json.merge(
      image_url: item.image.attached? ? url_for(item.image) : nil
    )
  end
end
