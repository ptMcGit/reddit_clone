FactoryGirl.define do
  factory :room do
    name        { Faker::Commerce.department }
    description { Faker::Hipster.sentence }
    user
  end
end
