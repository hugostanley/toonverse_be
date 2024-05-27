# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  amount          :decimal(15, 2)
#  art_style       :enum             not null
#  background_url  :string           not null
#  notes           :string
#  number_of_heads :integer          default(0), not null
#  picture_style   :enum             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  payment_id      :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_items_on_payment_id  (payment_id)
#  index_items_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Item < ApplicationRecord
  belongs_to :user
  belongs_to :payment, optional: true
  has_one :order
  has_one_attached :image

  validates :image, attached: true, content_type: %i[png jpg jpeg],
                    size: { less_than: 10.megabytes, message: 'File size is too large' }
  validates :background_url, presence: true
  validates :number_of_heads, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :art_style, presence: true
  validates :picture_style, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  before_create :calculate_amount

  enum :art_style, {
    vector: 'vector',
    bobs_burger: 'bobs_burger',
    rick_and_morty: 'rick_and_morty'
  }

  enum :picture_style, {
    full_body: 'full_body',
    half_body: 'half_body',
    shoulders_up: 'shoulders_up'
  }
  scope :unpaid_or_pending, lambda {
    left_joins(:payment).where('items.payment_id IS NULL OR payments.payment_status = ?', 'awaiting_payment_method')
  }



  private

  def calculate_amount
    self.class.transaction do
      base_amount = 100
      self.amount = number_of_heads * case picture_style
                                      when 'full_body' then 1 * base_amount
                                      when 'half_body' then 0.70 * base_amount
                                      when 'shoulders_up' then 0.5 * base_amount
                                      end
    end
  end
end
