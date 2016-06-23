class PostsController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @post = Post.find(params[:id])
    @messages = @post.messages
  end
end
