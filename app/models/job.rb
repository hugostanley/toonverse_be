# == Schema Information
#
# Table name: jobs
#
#  id           :bigint           not null, primary key
#  claimed_at   :datetime         not null
#  commision    :decimal(15, 2)   default(0.0), not null
#  total_paid   :decimal(15, 2)   default(0.0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :bigint           not null
#  workforce_id :bigint           not null
#
# Indexes
#
#  index_jobs_on_order_id      (order_id)
#  index_jobs_on_workforce_id  (workforce_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (workforce_id => workforces.id)
#
class Job < ApplicationRecord
  belongs_to :workforce
  belongs_to :order
  has_many :artwork
end
