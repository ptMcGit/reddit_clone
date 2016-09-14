class UserPolicy < ApplicationPolicy

  def index?
    user &&
      is_admin?
  end

  def show?
    user &&
      true
  end

  def destroy?
    # owner must go through devise
    user && (
        is_admin?
    )
  end

end
