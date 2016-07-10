class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many      :posts
  has_many      :votes
  has_many      :comments, through: :posts
  has_many      :rooms

  has_one :admin

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
