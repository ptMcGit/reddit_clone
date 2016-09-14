class RoomPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user
  end

  def new?
    user
  end

  def edit?
    user &&
      is_owner?
  end

  def create?
    user
  end

  def update?
    user &&
      is_owner?
  end

  def destroy?
    user && (
      is_owner? ||
      is_admin?
    )
  end

end
