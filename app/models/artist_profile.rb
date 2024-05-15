# == Schema Information
#
# Table name: artist_profiles
#
#  id              :bigint           not null, primary key
#  billing_address :string           not null
#  bio             :text
#  first_name      :string           not null
#  last_name       :string           not null
#  mobile_number   :string
#  total_earnings  :decimal(15, 2)   default(0.0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  workforce_id    :bigint           not null
#
# Indexes
#
#  index_artist_profiles_on_workforce_id  (workforce_id)
#
# Foreign Keys
#
#  fk_rails_...  (workforce_id => workforces.id)
#
class ArtistProfile < ApplicationRecord
  belongs_to :workforce

  validates :first_name, presence: true, format: { with: /\A[a-zA-Z\-. ]+\z/, message: 'can only contain letters, hyphens, periods, and spaces' }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z\-. ]+\z/, message: 'can only contain letters, hyphens, periods, and spaces' }
  validates :mobile_number, format: { with: /\A[\d+\-]+\z/, message: 'can only contain numbers, hyphens, and plus signs'}
  validates :billing_address, presence: true
  validates :bio, length: { in: 0..120 }
  # validates :workforce_id, uniqueness: { message: 'Artist already has a profile' }, on: :create
end
