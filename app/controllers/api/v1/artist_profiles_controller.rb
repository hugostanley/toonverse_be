class Api::V1::ArtistProfilesController < ApplicationController
  before_action :authenticate_workforce!
  before_action :set_artist_profile, except: [:index, :create]

  def index
    if current_workforce.admin?
      @artist_profiles = ArtistProfile.includes(:workforce).all.order(created_at: :desc)
    else
      @artist_profiles = current_workforce.artist_profile.present? ? [current_workforce.artist_profile] : []
    end

    workforce_profiles = @artist_profiles.map do |profile|
      {
        id: profile.id,
        first_name: profile.first_name,
        last_name: profile.last_name,
        email: profile.workforce.email,
        billing_address: profile.billing_address,
        mobile_number: profile.mobile_number,
        bio: profile.bio,
        total_earnings: profile.total_earnings,
        workforce_id: profile.workforce_id,
        created_at: profile.created_at,
        updated_at: profile.updated_at
      }
    end

    render json: workforce_profiles,
    status: :ok
  end

  def show
    render json: {
      artist_profile: @artist_profile.as_json.merge(email: @artist_profile.workforce.email)
    },
    status: :ok
  end

  def create
    @artist_profile = ArtistProfile.where(workforce_id: current_workforce.id).first_or_initialize

    if @artist_profile.update(artist_profile_params)
      render json: {
        artist_profile: @artist_profile.as_json.merge(email: @artist_profile.workforce.email)
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
    if @artist_profile.update(artist_profile_params) && @artist_profile.workforce.update(workforce_params)
      render json: {
        artist_profile: @artist_profile.as_json.merge(email: @artist_profile.workforce.email)
      },
      status: :ok
    else
      render json: {
        error: @artist_profile.errors.full_messages + @artist_profile.workforce.errors.full_messages,
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
    @artist_profile = ArtistProfile.find(params[:id])

    unless @artist_profile.workforce_id == current_workforce.id || current_workforce.admin?
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
