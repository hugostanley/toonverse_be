class Order < ApplicationRecord
  belongs_to :payment
  has_one :payment
  has_one :order_specifications
  has_one :artwork

  enum status: { in_queue: 'In Queue', in_progress: 'Order In Progress', delivered: 'Delivered', completed: 'Order Complete', cancelled: 'Cancelled'}

  validates :status, presence: true, inclusion: { in: status.keys }

end
