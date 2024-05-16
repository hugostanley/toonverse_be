class ItemController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item, only: [:show, :update, :destroy]

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
      @item = current_user.item.build(item_params)
  
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
      @item = current_user.item.find(params[:id])
    end
  
    def item_params
      params.require(:item).permit(
        :user_id,
        :background_url,
        :number_of_heads,
        :picture_style,
        :notes,
        :ref_photo_url,
        :amount
      )
    end
end