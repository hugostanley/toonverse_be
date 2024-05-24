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
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
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
#  invited_by_id          :bigint
#
# Indexes
#
#  index_workforces_on_confirmation_token    (confirmation_token) UNIQUE
#  index_workforces_on_email                 (email) UNIQUE
#  index_workforces_on_invitation_token      (invitation_token) UNIQUE
#  index_workforces_on_invited_by            (invited_by_type,invited_by_id)
#  index_workforces_on_invited_by_id         (invited_by_id)
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
  has_many :jobs, through: :orders, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
end
