class UsersController < ApplicationController

  after_action :verify_authorized

  def index
    @users = User.order(:username).page params[:page]
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    if @user.destroy
      flash[:success] = "User has been deleted."
    else
      handle_soft_error @user.errors.full_messages
    end
    redirect_back
  end

end
