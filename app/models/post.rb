class Post < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  has_many :messages
end
