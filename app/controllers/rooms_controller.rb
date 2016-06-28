class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new(
      )
  end

  def create
    r = Room.create!(
      approved_params.merge({ user_id: current_user.id})
    )
      flash[:notice] = "Room successfully created."
      redirect_to rooms_path
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
    redirect_to room_path
  end

  def show
    @room = Room.find(params[:id])
    @posts = @room.posts
  end

  def destroy
    @room = Room.find(params[:id])
    authorize @room
    @room.destroy
    redirect_to rooms_path
  end

  def approved_params
    params.require(:room).permit(
      :name,
      :description
    )
  end


end
