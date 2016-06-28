class Room < ActiveRecord::Base
  has_many :posts
  has_one  :moderator
end
