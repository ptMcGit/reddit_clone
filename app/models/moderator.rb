class Moderator < ActiveRecord::Base
  has_one   :user
  has_one   :room, foreign_key: 'user_id'
end
