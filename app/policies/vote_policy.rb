class VotePolicy < ApplicationPolicy

  def vote?
    is_owner?
  end

end
