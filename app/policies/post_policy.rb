class PostPolicy < ApplicationPolicy
  def index?
    user &&
      is_admin?
    scope.all
  end

  def show?
    user
  end

  def new?
    user &&
      is_owner?
  end

  def edit?
    user &&
      is_owner?
  end

  def create?
    user &&
      is_owner?
  end

  def update?
    user &&
      is_owner?
  end

  def destroy?
    user && (
      is_moderator? ||
      is_owner? ||
      is_admin?
    )
  end

  private

  def is_moderator?
    Moderator.where(room_id: @record.room_id).pluck(:user_id).include? @user.id
  end

end
