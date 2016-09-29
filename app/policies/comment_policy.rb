class CommentPolicy < ApplicationPolicy

  def create?
    user &&
      is_owner?
  end

end
