FactoryGirl.define do
  factory :vote do
    post
    user
    value [1, -1].sample
  end
end
