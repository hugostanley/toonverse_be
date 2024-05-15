class Api::V1::UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile, except: [:index, :create]

  # Required Headers: uid, client, access-token, authorization, expiry

  # GET /api/v1/user_profiles
  def index
    #  TODO: modify authorization allowing admin only to access all user profiles
    @user_profiles = UserProfile.includes(:user).all
    user_profiles = @user_profiles.map do |profile|
      {
        id: profile.id,
        email: profile.user.email,
        first_name: profile.first_name,
        last_name: profile.last_name,
        billing_address: profile.billing_address
      }
    end

    render json: user_profiles,
    status: :ok
  end

  # GET /api/v1/user_profiles/:id
  def show
    render json: {
      user_profile: @user_profile.as_json.merge(email: current_user.email)
    }, status: :ok
  end

  # POST /api/v1/user_profiles
  # Sample Request Body:
  # {
  #   "user_profile": {
  #       'first_name': "first name",
  #       'last_name': 'last name,
  #       'billing_address': 'billing address'
  #   }
  def create
    @user_profile = UserProfile.where(user_id: current_user.id).first_or_initialize

    if @user_profile.update(user_profile_params)
      render json: {
        user_profile: @user_profile.as_json.merge(email: current_user.email)
        },
        status: :ok
    else
      render json: {
        error: @user_profile.errors.full_messages,
        status: 'failed'
        },
        status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/user_profiles/:id
  # Sample Request Body:
  # {
  #   "user_profile": {
  #       'first_name': "first name",
  #       'last_name': 'last name,
  #       'billing_address': 'billing address'
  #   },
  #   "user": {
  #       'email': 'hellojane@email.com',
  #       'password': 'password', (optional)
  #       'password_confirmation': 'password' (optional)
  #   }
  # }
  def update
    if @user_profile.update(user_profile_params) && current_user.update(user_params)
      render json: {
        user_profile: @user_profile.as_json.merge(email: current_user.email)
        },
        status: :ok
    else
      render json: {
        error: @user_profile.errors.full_messages + current_user.errors.full_messages,
        status: 'failed'
        },
        status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/user_profiles/:id
  # Required Headers: uid, client, access-token
  def destroy
    if @user_profile.destroy
      render json: {
        message: 'User profile permanently deleted',
        status: 'success'
        },
        status: :ok
    end
  end

  private

  def set_user_profile
    # TODO: Allow admin to access any specific user_profile
    @user_profile = UserProfile.find(params[:id])

    unless @user_profile.user_id == current_user.id
      render json: {
        error: "You are not authorized to access this profile"
      }, status: :unauthorized
    end

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "User profile not found"
    },
    status: :not_found
  end

  def user_profile_params
    params.require(:user_profile).permit(:first_name, :last_name, :billing_address)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
