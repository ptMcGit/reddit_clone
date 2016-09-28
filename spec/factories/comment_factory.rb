FactoryGirl.define do
  factory :comment do
    user
    association :commentable, factory: :post
    content     { Faker::Lorem.sentence }
  end
end
