class CommentPolicy < ApplicationPolicy

  def create?
    user &&
      is_owner?
  end

  def update?
    user &&
      is_owner?
  end

  def destroy?
    user &&
      (is_owner? || is_admin?)
  end
end
