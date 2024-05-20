class Payment < ApplicationRecord
  belongs_to :user
  has_many :items

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
