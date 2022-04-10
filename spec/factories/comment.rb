FactoryBot.define do
  factory :comment do
    association :user
    association :post

    content { FFaker::Lorem.sentence }
  end
end