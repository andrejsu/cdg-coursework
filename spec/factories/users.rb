FactoryBot.define do
  factory :user do
    nickname { FFaker::Internet.unique.user_name }
    email { FFaker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
