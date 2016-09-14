class PostPolicy < ApplicationPolicy
  def index?
    user &&
      is_admin?
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

end
