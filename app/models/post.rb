class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :image_data, presence: true
  validates :description, presence: true, length: { maximum: 2200 }
end
