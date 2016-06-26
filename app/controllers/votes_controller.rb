class VotesController < ApplicationController
  def create
    Vote.create(
      post_id: approved_params[:post_id],
      value:    approved_params[:value],
      user_id: current_user.id
    )
    raise
    redirect_to :back
  end

  def approved_params
    params.permit(
      :post_id,
      :value
    )
  end
end
