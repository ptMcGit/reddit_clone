class VotePolicy < ApplicationPolicy

  def create?
    is_owner?
  end

end
