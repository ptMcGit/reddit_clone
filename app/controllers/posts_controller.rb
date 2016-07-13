class PostsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  after_action :verify_authorized

  def index
    @posts = Post.all
    authorize @posts
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    authorize @post
  end

  def new
    @post = @room.posts.new
    authorize @post
  end

  def create
    @post = @room.posts.new( approved_params.merge(user_id: current_user.id) )
    authorize @post

    if @post.save
      flash[:notice] = "successful post"
      redirect_to @room
    else
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post

    #if @post.created_at > 1.hour.ago
    #  flash[:notice] = "unable to update."
    #else
    @post.update(
      content: approved_params[:content]
    )
    flash[:notice] = "successfully updated."
    #end
      #redirect_to room_path(approved_params[:room_id])
      redirect_to room_path(@post.room)
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    Post.delete(params[:id])
    flash[:notice] = "Post succesfully deleted."
    redirect_to room_path(params[:room_id])
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def approved_params
    params.permit(
      :title,
      :content,
      :room_id
    )
  end

end
