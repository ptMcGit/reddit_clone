FactoryGirl.define do
  factory :admin do
    user
  end

  factory :moderator do
    user
    room
  end

  factory :user do
    email { Faker::Internet.safe_email }
    password "password"

    factory :user_who_is_admin do
      after(:create) do |user, evaluator|
        create_list(:admin, 1, user: user)
      end
    end
    factory :user_who_is_mod do
      after(:create) do |user, evaluator|
        create_list(:moderator, 1, user: user, room: create(:room))
      end
    end
  end
end
