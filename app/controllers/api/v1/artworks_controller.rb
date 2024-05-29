class Api::V1::ArtworksController < ApplicationController
  before_action :authenticate_workforce!
  before_action :set_artwork, only: %i[show update destroy]

  def index
    @artworks = if current_workforce.artist?
                  current_workforce.artworks.order(created_at: :desc)
                else
                  Artwork.all.order(created_at: :desc)
                end
    render json: @artworks
  end

  def show
    render json: @artwork
  end

  def create
    @artwork = current_workforce.artworks.build(artwork_params)

    if @artwork.save
      render json: @artwork, status: :created
    else
      render json: @artwork.errors, status: :unprocessable_entity
    end
  end

  def update
    if @artwork.update(artwork_params)
      render json: @artwork
    else
      render json: @artwork.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @artwork.destroy!
    render json: { message: 'Artwork successfully deleted' }, status: :ok
  end

  private

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(
      :job_id,
      :revision_number,
      :digital_artwork
    )
  end
end
