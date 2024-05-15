class Order < ApplicationRecord
  belongs_to :payment
  has_one :payment
  has_one :order_specifications
  has_one :artwork

  enum status: { in_queue: 0, order_in_progress: 1, delivered: 2, completed: 3, cancelled: 4}

  validates :status, presence: true, inclusion: { in: status.keys }

end
