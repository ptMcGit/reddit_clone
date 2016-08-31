class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many      :posts, dependent: :nullify
  has_many      :votes, dependent: :destroy
  has_many      :comments, through: :posts, dependent: :destroy
  has_many      :rooms, dependent: :nullify

  has_one :admin

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
