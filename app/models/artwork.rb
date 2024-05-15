class Artwork < ApplicationRecord
  belongs_to :order
  belongs_to :job
end
