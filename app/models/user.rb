class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :appointments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 200 }
  validates :username, presence: true, length: { maximum: 20 }
  validates :email, presence: true
  validates :password, presence: true

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email:)
    user&.valid_password?(password) ? user : nil
  end
end
