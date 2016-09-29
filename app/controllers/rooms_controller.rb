class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  after_action :verify_authorized

  def index
    @rooms = Room.order(:name).page params[:page]
    skip_authorization
  end

  def show
    @room = Room.find(params[:id])
    @posts = @room.posts
    @votes = {}
    current_user.votes.map { |o| @votes[o.post_id] = o.value }
    authorize @room
  end

  def new
    @room = Room.new
    authorize @room
  end

  def edit
    @room = Room.find(params[:id])
    authorize @room
  end

  def create
    @room = Room.new(
      approved_params.merge({ user_id: current_user.id})
    )
    authorize @room
    if @room.save
      flash[:success] = "Room successfully created."
      redirect_to rooms_path
    else
      flash.now[:warning] =  @room.errors.full_messages
      render :new
    end
  end

  def update
    @room = Room.find(params[:id])
    authorize @room

    @room.update(approved_params)

    if @room.save
      flash[:success] = "Room successfully updated."
      redirect_to rooms_path
    else
      flash.now[:warning] =  @room.errors.full_messages
      render :new
    end
  end

  def destroy
    @room = Room.find(params[:id])
    authorize @room
    if @room.destroy
      flash[:success] = "#{@room.name} is no longer..."
    else
      handle_soft_error @room.errors.full_messages
    end

    redirect_to rooms_path

  end

  def approved_params
    params.require(:room).permit(
      :name,
      :description
    )
  end


end
