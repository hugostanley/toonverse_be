# == Schema Information
#
# Table name: orders
#
#  id                 :bigint           not null, primary key
#  amount             :decimal(15, 2)   default(0.0), not null
#  latest_artwork_url :string           not null
#  order_status       :enum             default("in_queued"), not null
#  remarks            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  payment_id         :bigint           not null
#
# Indexes
#
#  index_orders_on_payment_id  (payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_id => payments.id)
#
class Order < ApplicationRecord
  belongs_to :payment
  has_one :payment
  has_one :artwork

  enum :order_status,{
    in_queued: 'in_queued',
    in_progress: 'in_progress',
    delivered: 'delivered',
    completed: 'completed',
    cancelled: 'cancelled'
  }, default: 'in_queued'

end
