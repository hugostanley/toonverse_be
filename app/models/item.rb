# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  amount          :decimal(15, 2)   default(0.0)
#  background_url  :string           not null
#  notes           :string
#  number_of_heads :integer          default(0), not null
#  picture_style   :enum             not null
#  ref_photo_url   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Item < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :payments

  enum :picture_style, {
    vector: 'vector',
    bobs_burger: 'bobs_burger',
    rick_and_morty: 'rick_and_morty'
  }

  validates :background_url, presence: true
  validates :number_of_heads, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :picture_style, presence: true
  validates :ref_photo_url, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
