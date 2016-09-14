FactoryGirl.define do
  factory :post do
    title   { Faker::Book.title }
    content { Faker::Hipster.paragraph }
    room
    user
  end
end
