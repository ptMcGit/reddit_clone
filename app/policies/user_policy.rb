class UserPolicy < ApplicationPolicy

  def index?
    is_admin?
  end

  def show?
    if @record.deactivated
      return is_admin?
    end
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
