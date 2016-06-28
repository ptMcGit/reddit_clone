class VotesController < ApplicationController
  def create
    cast_vote = current_user.votes.find_by(post_id: approved_params[:post_id])
    if cast_vote
      cast_vote.update!(value: approved_params[:value])
    else
      Vote.create(
        post_id: approved_params[:post_id],
        value:    approved_params[:value],
        user_id: current_user.id
      )
    end
    #else
      #flash[:notice] = "You are not allowed to vote on that post again!"

      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: {status:  :ok } }
      end

     #end

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
