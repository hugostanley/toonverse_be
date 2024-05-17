# == Schema Information
#
# Table name: artworks
#
#  id              :bigint           not null, primary key
#  artwork_url     :string           not null
#  revision_number :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  job_id          :bigint           not null
#  order_id        :bigint           not null
#
# Indexes
#
#  index_artworks_on_job_id    (job_id)
#  index_artworks_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_id => jobs.id)
#  fk_rails_...  (order_id => orders.id)
#
class Artwork < ApplicationRecord
  belongs_to :order
  belongs_to :job
end
