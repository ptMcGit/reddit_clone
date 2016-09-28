FactoryGirl.define do
  factory :admin do
    user
  end

  factory :moderator do
    user
    room
  end

  factory :user do
    username    { Faker::Internet.user_name }
    email       { Faker::Internet.safe_email }
    password    "password"

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
    factory :user_with_post do
      after(:create) do |user, evaluator|
        create_list(:post, 1, user: user, room: Room.all.sample)
      end
    end
    factory :user_with_comments do
      after(:create) do |user, evaluator|
        create_list(:comment, 10, user: user, commentable: Post.all.sample)
      end
    end
    factory :user_with_votes do
      after(:create) do |user, evaluator|
        create_list(:vote, 10, user: user, post: Post.all.sample)
      end
    end
  end
end
