# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: [:google_oauth2]
  include DeviseTokenAuth::Concerns::User

  has_one :user_profile, dependent: :destroy
  has_many :item

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user.try(:valid_password?, password) ? user : nil
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session["devise.oauth_data"].present?
        provider = session["devise.oauth_data"]["provider"]
        if provider == "google_oauth2"
          if data = session["devise.oauth_data"]
            user.email = data["info"]["email"] if user.email.blank?
          end
        end
      end
    end
  end

  # first_or_create acts as both signup and signin
  def self.from_google_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.extra.id_info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #     user.skip_confirmation!
  #   end
  # end

  # def self.from_omniauth(user_info)
  #   email = user_info['email']
  #   user = User.where(email: email).first

  #   password = Devise.friendly_token[0,20]
  #   unless user
  #     user = User.create(
  #       name: user_info['name'],
  #       email: email,
  #       password: password,
  #       password_comfirmation: password
  #     )
  #   end

  #   user
  # end
end
