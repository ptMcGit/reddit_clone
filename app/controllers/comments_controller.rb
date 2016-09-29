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

    redirect_back

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

    redirect_back

  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    flash[:success] = "Comment successfully deleted."

    redirect_back

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
