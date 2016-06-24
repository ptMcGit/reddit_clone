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
