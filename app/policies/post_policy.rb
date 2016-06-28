class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def index?
    user.is_admin?
  end

  def destroy?
    is_moderator? ||
      is_owner? ||
      is_admin?
  end

  private

  def is_owner?
    @user == @post.user
  end

end
