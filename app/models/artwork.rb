# == Schema Information
#
# Table name: artworks
#
#  id              :bigint           not null, primary key
#  artwork_url     :string
#  revision_number :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  job_id          :bigint           not null
#  workforce_id    :bigint           not null
#
# Indexes
#
#  index_artworks_on_job_id        (job_id)
#  index_artworks_on_workforce_id  (workforce_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_id => jobs.id)
#  fk_rails_...  (workforce_id => workforces.id)
#
class Artwork < ApplicationRecord
  belongs_to :job
  belongs_to :workforce
  has_one_attached :digital_artwork

  validates :digital_artwork, attached: true, content_type: %i[png jpg jpeg],
                              size: { less_than: 20.megabytes, message: 'File size is too large' }
  validates :revision_number, presence: true

  before_create :set_revision_number
  after_create_commit :set_artwork_url

  # TODO
  # re run the set artwork url
  # after_update :set_artwork_url

  private

  def set_revision_number
    transaction do
      latest_artwork = Artwork.where(job_id:).order(:revision_number).last
      self.revision_number = latest_artwork.present? ? latest_artwork.revision_number + 1 : 0
    end
  end

  def set_artwork_url
    transaction do
      update_column(:artwork_url,
                    digital_artwork.attached? ? Rails.application.routes.url_helpers.rails_blob_url(digital_artwork,
                                                                                                    only_path: true) : '')
      # Update ORDER record -> latest artwork URL
    end
  end
end
