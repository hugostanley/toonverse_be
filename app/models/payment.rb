# == Schema Information
#
# Table name: payments
#
#  id                  :bigint           not null, primary key
#  item_ids            :integer          default([]), is an Array
#  payment_status      :enum             default("pending"), not null
#  total_amount        :decimal(10, 2)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  checkout_session_id :text
#  user_id             :bigint           not null
#
# Indexes
#
#  index_payments_on_item_ids  (item_ids)
#  index_payments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Payment < ApplicationRecord
  belongs_to :user

  enum payment_status: {
    pending: 'awaiting_payment_method',
    paid: 'paid',
    cancelled: 'cancelled'
  }

  validates :item_ids, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_status, presence: true
  validates :checkout_session_id, presence: true
end
