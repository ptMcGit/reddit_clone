class Room < ActiveRecord::Base
  has_many      :posts
  has_many      :moderators
end
