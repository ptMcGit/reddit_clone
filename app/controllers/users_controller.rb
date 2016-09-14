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
    @user.destroy
    flash[:success] = "User has been deleted."
    redirect_to (request.env['HTTP_REFERER'] || root_path)
  end

end
