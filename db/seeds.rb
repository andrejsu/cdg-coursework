srand(972943150)
FFaker::Random.seed = 972943150

User.create!(nickname: "andrew",
             name:  "Andrew",
             email: "test@test",
             password:              "619736",
             password_confirmation: "619736")

99.times do |n|
  nickname = FFaker::Internet.unique.user_name
  name  = FFaker::Name.name
  email = FFaker::Internet.unique.email
  password = "619736"
  User.create!(nickname: nickname,
               name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# User.all.each { |user|
#   num_posts = rand(1..30)
#   num_posts.times {
#     # uploader = ImageUploader.new(:cache)
#     # image = uploader.upload(Faker::LoremFlickr.image)
#     description = FFaker::Lorem.sentences(sentence_count = rand(1..5))
#     post = user.posts.create(description: description)
#     post.created_at = rand(1..60*24).minutes.ago
#     post.save
#   }
# }

all_users = User.all
all_users.each { |user|
  num_follow = rand(0..all_users.length)
  all_users.shuffle[0..num_follow].each{ |other|
    if user != other
      user.follow(other)
    end
  }
}