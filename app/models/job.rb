class Job < ApplicationRecord
  belongs_to :workforce
  belongs_to :order
  has_many :artwork
end
