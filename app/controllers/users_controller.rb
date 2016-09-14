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
  end

end
