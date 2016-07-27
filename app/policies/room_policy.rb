class RoomPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def edit?
    is_owner?
  end

  def create?
    true
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner? ||
      is_admin?
  end
end
