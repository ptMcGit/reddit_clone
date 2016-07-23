class RoomsController < ApplicationController

  skip_before_action :authenticate_user!, only: :index
  skip_after_action :verify_authorized, only: [:index, :show, :new, :create]

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @posts = @room.posts
    @votes = {}
    current_user.votes.map { |o| @votes[o.post_id] = o.value }
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(
      approved_params.merge({ user_id: current_user.id})
    )
    if @room.save
      flash[:notice] = "Room successfully created."
      redirect_to rooms_path
    else
      flash[:notice] =  @room.errors.full_messages
      render :new
    end
  end

  def destroy
    @room = Room.find(params[:id])
    authorize @room
    @room.destroy
    redirect_to rooms_path
  enod

  def approved_params
    params.require(:room).permit(
      :name,
      :description
    )
  end


end
