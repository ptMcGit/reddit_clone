class Moderator < ActiveRecord::Base
  has_one   :user
  belongs_to  :room
end
