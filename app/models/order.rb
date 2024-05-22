# == Schema Information
#
# Table name: orders
#
#  id                 :bigint           not null, primary key
#  amount             :decimal(, )      not null
#  latest_artwork_url :text
#  order_status       :enum             default("queued"), not null
#  remarks            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  item_id            :bigint           not null
#  payment_id         :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_orders_on_item_id     (item_id)
#  index_orders_on_payment_id  (payment_id)
#  index_orders_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (payment_id => payments.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :payment
  belongs_to :item
  belongs_to :user

  enum :order_status, {
    queued: 'queued',
    in_progress: 'in_progress',
    delivered: 'delivered',
    completed: 'completed',
    cancelled: 'cancelled'
  }

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :order_status, presence: true
end