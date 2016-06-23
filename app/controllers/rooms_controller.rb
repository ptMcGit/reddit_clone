class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
  end

  def edit
  end

  def show
    @room = Room.find(1)
    @posts = @room.posts
  end
end
