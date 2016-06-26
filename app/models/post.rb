class Post < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  has_many :comments
  has_many :votes
end
