class Workforce < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 'admin', illustrator: 'illustrator' }

  validates :role, presence: true, inclusion: { in: roles.keys }

  has_one :workforce_profile
  has_many :job
  has_many :artwork, through: :job
end
