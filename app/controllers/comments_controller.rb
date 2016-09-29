class CommentsController < ApplicationController
  after_action :verify_authorized

  def index
  end

  def show
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment

    if @comment.save
      flash[:success] = "comment added"
    else
      flash[:warning] =  @comment.errors.full_messages
    end

    if request.env["HTTP_REFERER"]
      redirect_to(:back)
    else
      not_found
    end
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.update(comment_params)

    if @comment.save
      flash[:success] = "successfully updated."
    else
      flash[:warning] =  @post.errors.full_messages
    end

    if request.env["HTTP_REFERER"]
      redirect_to(:back)
    else
      not_found
    end

  end

  private

  def comment_params
    params.require(:comment).permit(
      :commentable_id,
      :commentable_type,
      :content
    ).
      merge(user_id: current_user.id)
  end
end
