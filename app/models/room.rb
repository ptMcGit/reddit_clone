class Room < ActiveRecord::Base
  has_many      :posts
  has_many      :moderators
  belongs_to    :user

  after_create do
    Moderator.create!(
      user_id: self.user_id,
      room_id: self.id
    )
  end

end
