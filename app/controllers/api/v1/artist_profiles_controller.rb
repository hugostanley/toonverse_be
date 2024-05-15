class Api::V1::ArtistProfilesController < ApplicationController
  before_action :authenticate_workforce!
  before_action :set_artist_profile, except: [:index, :create]

  def index
    if current_workforce.admin?
      @artist_profiles = ArtistProfile.include(:workforce).all
    else
      @artist_profiles = current_workforce.artist_profile
    end

    render json: @artist_profiles,
    status: :ok
  end

  def show
    render json: {
      artist_profile: @artist_profile.as_json.merge(email: current_workforce.email)
    },
    status: :ok
  end

  def create
    @artist_profile = ArtistProfile.where(workforce_id: current_workforce.id).first_or_initialize

    if @artist_profile.update(artist_profile_params)
      render json: {
        artist_profile: @artist_profile.as_json.merge(email: current_workforce.email)
      },
      status: :ok
    else
      render json: {
        error: @artist_profile.errors.full_messages,
        status: 'failed'
      },
      status: :unprocessable_entity
    end
  end

  def update
    if @artist_profile.update(artist_profile_params) && current_workforce.update(workforce_params)
      render json: {
        artist_profile: @artist_profile.as_json.merge(email: current_workforce.email)
      },
      status: :ok
    else
      render json: {
        error: @artist_profile.errors.full_messages + current_workforce.errors.full_messages,
        status: 'failed'
      },
      status: :unprocessable_entity
    end
  end

  def destroy
    if @artist_profile.destroy
      render json: {
        message: 'Artist profile permanently deleted',
        status: 'success'
      },
      status: :ok
    end
  end

  private

  def set_artist_profile
    # TODO: Allow admin to access any specific artist_profile
    @artist_profile = ArtistProfile.find(params[:id])

    unless @artist_profile.workforce_id == current_workforce.id
      render json: {
        message: "You are not authorized to access this profile"
      },
      status: :unauthorized
    end

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Artist profile not found"
    },
    status: :not_found
  end

  def artist_profile_params
    params.require(:artist_profile).permit(:first_name, :last_name, :billing_address, :bio, :mobile_number)
  end

  def workforce_params
    params.permit(:email, :password, :password_confirmation)
  end
end
