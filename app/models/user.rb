class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_voter

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :follower_follows, foreign_key: :following_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_follows, source: :follower

  has_many :following_follows, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followings, through: :following_follows, source: :following

  validates :nickname, presence: true, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 50 }
  validates :bio, length: { maximum: 300 }

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def followed_by?(other_user)
    followers.include?(other_user)
  end
end
