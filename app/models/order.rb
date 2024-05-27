# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  amount       :decimal(, )      not null
#  order_status :enum             default("queued"), not null
#  remarks      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_id      :bigint           not null
#  payment_id   :bigint           not null
#  user_id      :bigint           not null
#  workforce_id :bigint
#
# Indexes
#
#  index_orders_on_item_id       (item_id)
#  index_orders_on_payment_id    (payment_id)
#  index_orders_on_user_id       (user_id)
#  index_orders_on_workforce_id  (workforce_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (payment_id => payments.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (workforce_id => workforces.id)
#
class Order < ApplicationRecord
  belongs_to :payment
  belongs_to :item
  belongs_to :user
  belongs_to :workforce, optional: true
  has_one :job, dependent: :destroy
  has_many :artworks, through: :jobs, dependent: :destroy

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :order_status, presence: true

  after_update :create_job

  enum :order_status, {
    queued: 'queued',
    in_progress: 'in_progress',
    delivered: 'delivered',
    completed: 'completed',
    cancelled: 'cancelled'
  }

  private

  def create_job
    return unless saved_change_to_order_status? && order_status == 'in_progress'

    commission = amount * 0.7
    transaction do
      Job.create!(
        order_id: id,
        claimed_at: Time.current,
        commission:
      )
    end
  end
end
