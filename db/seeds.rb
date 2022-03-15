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

uploader = ImageUploader.new(:cache)




User.all.each { |user|
  num_posts = rand(1..2)
  num_posts.times {
    file = Down.download('https://picsum.photos/1080/1080')
    uploaded_file = uploader.upload(file)

    description = FFaker::Lorem.sentences(sentence_count = rand(1..5))
    post = user.posts.create(description: description, image_data: uploaded_file.to_json)
    post.created_at = rand(1..60*24).minutes.ago
    post.save
  }
}

all_users = User.all
all_users.each { |user|
  num_follow = rand(0..all_users.length)
  all_users.shuffle[0..num_follow].each{ |other|
    if user != other
      Follow.create(follower: user, following: other)
    end
  }
}