# frozen_string_literal: true

# == Schema Information
#
# Table name: workforces
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
#  role                   :enum             default("artist"), not null
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_workforces_on_confirmation_token    (confirmation_token) UNIQUE
#  index_workforces_on_email                 (email) UNIQUE
#  index_workforces_on_reset_password_token  (reset_password_token) UNIQUE
#  index_workforces_on_uid_and_provider      (uid,provider) UNIQUE
#
class Workforce < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum :role, {
    admin: 'admin',
    artist: 'artist'
  }, default: 'artist'

  has_one :artist_profile, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
end
