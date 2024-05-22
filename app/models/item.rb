class Item < ApplicationRecord
  belongs_to :user
  belongs_to :payment, optional: true
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

  validates :background_url, presence: true
  validates :number_of_heads, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :art_style, presence: true
  validates :picture_style, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  private

  def calculate_amount
    self.class.transaction do
      self.amount = number_of_heads * case picture_style
                                      when 'full_body' then 100
                                      when 'half_body' then 75
                                      when 'shoulders_up' then 50
                                      end
    end
  end
end