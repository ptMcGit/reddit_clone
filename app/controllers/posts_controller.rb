class PostsController < ApplicationController
  def index
  end

  def new
       @post = Post.new(
         room_id: params[:room_id],
         created_at: Time.now
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    #if @post.created_at > 1.hour.ago
    #  flash[:notice] = "unable to update."
    #else
      @post.update(
         content: approved_params[:content]
       )
      flash[:notice] = "successfully updated."
    #end
    redirect_to room_url(approved_params[:room_id])
  end

  def show
    @post = Post.find(params[:id])
    @messages = @post.messages
  end

  def approved_params
    params.require(:post).permit(
      :content,
      :room_id
    )
  end
end
