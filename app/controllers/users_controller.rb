class UsersController < ApplicationController

  skip_after_action :verify_authorized, only: [:new, :show]

  def index
    @users = User.all
  end

  def create
    user = User.create approved_params
    if user.save
      redirect_to rooms_path
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
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
