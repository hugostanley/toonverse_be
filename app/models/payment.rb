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
  has_many :orders

  enum payment_status: {
    pending: 'awaiting_payment_method',
    paid: 'paid',
    cancelled: 'cancelled'
  }

  validates :item_ids, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_status, presence: true
  validates :checkout_session_id, presence: true

  after_create :associate_with_item
  after_update :create_order_if_paid

  def associate_with_item
    transaction do
      item_ids.each do |item_id|
        item = Item.find(item_id)
        item.update(payment_id: id)
      end
    end
  end

  def create_order_if_paid
    return unless saved_change_to_payment_status? && payment_status == 'paid'

    transaction do
      item_ids.each do |item_id|
        item = Item.find(item_id)
        Order.create!(
          item_id: item.id,
          payment_id: id,
          user_id:,
          amount: item.amount,
          order_status: 'queued'
        )
      end
    end
  end
end
