# == Schema Information
#
# Table name: jobs
#
#  id         :bigint           not null, primary key
#  claimed_at :datetime
#  commission :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_jobs_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class Job < ApplicationRecord
  belongs_to :order

  # TODO
  # before_create: compute_commision
end
