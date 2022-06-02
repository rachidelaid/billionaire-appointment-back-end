class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :name, presence: true, length: {maximum: 200}
  validates :username, presence: true, length: {maximum: 20}
  validates :email, presence: true
  validates :password, presence: true
end
