class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments

  validates :nickname, presence: true, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 50 }
  validates :bio, length: { maximum: 300 }
end
