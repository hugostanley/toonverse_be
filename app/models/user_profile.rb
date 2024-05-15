# == Schema Information
#
# Table name: user_profiles
#
#  id              :bigint           not null, primary key
#  billing_address :string           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_user_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserProfile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true, format: { with: /\A[a-zA-Z\-. ]+\z/, message: 'can only contain letters, hyphens, periods, and spaces' }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z\-. ]+\z/, message: 'can only contain letters, hyphens, periods, and spaces' }
  validates :billing_address, presence: true
  validates :user_id, uniqueness: { message: 'User already has a profile' }, on: :create
end
