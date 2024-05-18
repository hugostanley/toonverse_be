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

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |u|
      u.email = auth.info.email
      # u.name = auth.info.name
      # u.password = Devise.friendly_token[0, 20]
      u.uid = auth.uid
      u.provider = auth.provider
    end
    user.save!
    user
  end

  def create_token
    # Check if the user already has an active token
    token = tokens.active.take || tokens.build

    # Set the token expiration (e.g., 2 weeks from now)
    token.expires_at = 2.weeks.from_now

    # Set the token body
    token.token_body = {
      uid:,
      provider:
    }

    # Save the token
    token.save!
    token
  end
end
