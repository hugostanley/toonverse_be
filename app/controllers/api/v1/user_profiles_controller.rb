class Api::V1::UserProfilesController < ApplicationController
  before_action :set_user_profile, except: [:index, :new, :create]
  before_action :authenticate_user!

  def index
    @user_profiles = UserProfile.all
    render json: @user_profiles
  end

  def show
    render json: @user_profile
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User profile not found" }, status: :not_found
  end

  def user_profile_params
    params.require(:user_profile).permit(:first_name, :last_name, :billing_address)
  end
end
