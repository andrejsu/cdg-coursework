FactoryBot.define do
  factory :post do
    association :user

    description { FFaker::Lorem.sentence }
    image { TestData.image_data }
  end
end
