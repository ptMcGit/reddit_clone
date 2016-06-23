class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    user = User.create approved_params
    if user.save
      redirect_to users_url
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def approved_params
    params.require(:user).permit(
      :name,
      :email,
      :password
    )
  end
end
