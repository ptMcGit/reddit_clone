class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new(
      )
  end

  def create
    r = Room.create(
         approved_params
       )
      flash[:notice] = "Room successfully created."
      redirect_to rooms
  end


  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    #if @post.created_at > 1.hour.ago
    #  flash[:notice] = "unable to update."
    #else
      @room.update(
         approved_params
       )
      flash[:notice] = "successfully updated."
      #end
    redirect_to room_url
  end

  def show
    @room = Room.find(1)
    @posts = @room.posts
  end

  def approved_params
    params.require(:room).permit(
      :name,
      :description
    )
  end


end
