class Api::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Like.filter_by_idea(params[:idea_id]).select(:id, :user_id, :idea_id)
  end

  def create
    current_user.likes.create!(likes_params)
    head :created
  end

  def destroy
    current_user.likes.find(params[:id]).destroy!
    head :ok
  end

  private

  def likes_params
    params.require(:like).permit(:idea_id)
  end
end
