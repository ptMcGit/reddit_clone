class VotesController < ApplicationController
  def create
    @vote = current_user.votes.find_or_create_by(post_id: approved_params[:post_id])
    authorize @vote
    if @vote
      @vote.update!(value: approved_params[:value])
    else
      Vote.create!(
        post_id: approved_params[:post_id],
        value:    approved_params[:value],
        user_id: current_user.id
      )
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: {status:  :ok } }
    end
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
