class PostsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  after_action :verify_authorized

  def index
    @posts = Post.order(:updated_at).page params[:page]
    authorize @posts
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    authorize @post
  end

  def new
    @post = @room.posts.new(user_id: current_user.id)
    authorize @post
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def create
    @post = @room.posts.new( approved_params.merge(user_id: current_user.id) )
    authorize @post

    if @post.save
      flash[:success] = "successful post"
      redirect_to @room
    else
      flash.now[:warning] =  @post.errors.full_messages
      render :new
    end

  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    @post.update(approved_params)

    if @post.save
      flash[:success] = "successfully updated."
      redirect_to room_path(@post.room)
    else
      flash.now[:warning] =  @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post

    if @post.destroy
      flash[:success] = "Post successfully deleted."
    else
      handle_soft_error @post.errors.full_messages
    end

    redirect_to room_path(params[:room_id])
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def approved_params
    params.require(:post).permit(
      :title,
      :content,
    )
  end

end
