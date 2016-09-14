module PunditHelper

  def is_owner?
    @user == @record.user
  end

  def is_admin?
    Admin.find_by(user_id: @user.id)
  end

  def is_moderator?
    Moderator.where(room_id: @record.room_id).pluck(:user_id).include? @user.id
  end

end
