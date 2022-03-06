class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)

  acts_as_votable

  belongs_to :user
end
