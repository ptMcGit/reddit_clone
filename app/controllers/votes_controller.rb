class VotesController < ApplicationController
  def create
    if user_can_vote
      Vote.create(
        post_id: approved_params[:post_id],
        value:    approved_params[:value],
        user_id: current_user.id
      )
    else
      #flash[:notice] = "You are not allowed to vote on that post again!"
    end
    redirect_to :back
  end

  def user_can_vote
    ! current_user.votes.find_by(post_id: approved_params[:post_id])
  end

  def approved_params
    params.permit(
      :post_id,
      :value
    )
  end
end
