FactoryGirl.define do
  factory :post do
    title   { Faker::Book.title }
    content { Faker::Hipster.sentences(5) }
    room
    user
  end
end
