class PostPolicy < ApplicationPolicy
  def index?
    is_admin?
  end

  def show?
    true
  end

  def new?
    is_owner?
  end

  def edit?
    is_owner?
  end

  def create?
    is_owner?
  end

  def update?
    is_owner?
  end

  def destroy?
    is_moderator? ||
      is_owner? ||
      is_admin?
  end

  private

  def is_moderator?
    Moderator.where(room_id: @record.room_id).pluck(:user_id).include? @user.id
  end


end
