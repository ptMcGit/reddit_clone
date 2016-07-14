FactoryGirl.define do
  factory :admin do
    user
  end
  factory :user do
    email { Faker::Internet.safe_email }
    password "password"

    factory :user_who_is_admin do
      after(:create) do |user, evaluator|
        create_list(:admin, 1, user: user)
      end
    end
  end


end
