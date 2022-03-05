class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :bio, presence: true, length: { maximum: 300 }
end
