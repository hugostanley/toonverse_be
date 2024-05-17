# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  item_amount :decimal(15, 2)   default(0.0), not null
#  remarks     :string
#  status      :enum             default("pending"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  item_id     :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_payments_on_item_id  (item_id)
#  index_payments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :order
  
  enum :status,{
    pending: 'pending',
    paid: 'paid',
    cancelled: 'cancelled',
    refunded: 'refunded'
  }, default: 'pending'


end
