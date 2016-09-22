class VotesController < ApplicationController

  def vote
    @vote = current_user.votes.find_by(post_id: approved_params[:post_id])

    if  @vote
      @vote.update(value: approved_params[:value])
    else
      @vote = current_user.votes.new(approved_params)
    end

    authorize @vote

    if @vote.save
      render json: {status: :ok}
    else
      render json: {status: :error}
    end
  end

private

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
