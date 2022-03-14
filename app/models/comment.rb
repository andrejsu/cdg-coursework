class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true, length: { minimum: 2, maximum: 1000 }
end
