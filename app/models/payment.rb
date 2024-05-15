class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :order

  enum status: { pending: 0, paid: 1, cancelled: 2, refunded: 3}

  validates :status, presence: true, inclusion: { in: status.keys }
end
