class Billionaire < ApplicationRecord

  has_many :appointments, dependent: :destroy

  validates :name, presence: true, length: {maximum: 200}, uniqueness: true
  validates :title, presence: true, length: {maximum: 200}
  validates :image, presence: true, uniqueness: true
  validates :price, numericality: true
  validates :description, presence: true, uniqueness: true

end
