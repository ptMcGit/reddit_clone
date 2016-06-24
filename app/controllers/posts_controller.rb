class PostsController < ApplicationController
  def index
  end

  def new
       @post = Post.new(
         room_id: params[:room_id]
       )
  end

  def create
    if @post = Post.create(
         approved_params.merge user_id: current_user.id
       )
      flash[:notice] = "successful post"
      redirect_to room_url(approved_params[:room_id])
    end
  end

  def edit
  end

  def show
    @post = Post.find(params[:id])
    @messages = @post.messages
  end

  def approved_params
    params.require(:post).permit(
      :content,
      :room_id,
    )
  end
end
