class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :billionaire

  validates :date, presence: true
  validates :city, presence: true, length: { maximum: 200 }
end
