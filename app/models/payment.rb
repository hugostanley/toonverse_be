class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :order

  enum status: { pending: 'Pending', paid: 'Paid', cancelled: 'Cancelled', refunded: 'Refunded'}

  validates :status, presence: true, inclusion: { in: status.keys }
end
