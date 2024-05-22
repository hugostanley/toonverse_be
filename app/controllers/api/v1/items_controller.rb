class Api::V1::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[show update destroy]

  # GET /items
  def index
    @items = current_user.items
    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = current_user.items.build(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
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
      :notes
    )
  end
end
