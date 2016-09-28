class Post < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes

  validates :content, presence: true
  validates :title, presence: true

  def sum
    self.votes.sum("value")
  end

end
