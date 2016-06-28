class RoomPolicy < ApplicationPolicy
  attr_reader :user, :room

  def initialize(user, room)
    @user = user
    @room = room
  end

  def destroy?
    is_owner? ||
      is_admin?
  end

  private

  def is_owner?
    @user == @room.user
  end

end
