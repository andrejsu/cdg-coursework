FactoryBot.define do
  factory :like do
    for_post

    trait :for_post do
      association :likeable, factory: :post
    end

    trait :for_comment do
      association :likeable, factory: :comment
    end
  end
end
