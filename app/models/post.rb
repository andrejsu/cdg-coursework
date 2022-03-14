class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
