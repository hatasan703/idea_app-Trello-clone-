class Api::JoinsController < ApplicationController
  before_action :set_idea_id

  def index
    render json: IdeaMember.where(idea_id: @idea_id).select(:id, :user_id, :idea_id) if @idea_id
    # 後で修正
  end
  def create
    @company = Idea.find(@idea_id).company
    if current_user.idea_members.find_by(idea_id: @idea_id)
      redirect_to public_company_ideas_path(@company)
    else
      current_user.idea_members.create!(join_params)
      head :created
    end
  end

  def destroy
  end

  private

  def set_idea_id
    @idea_id = params[:idea_id]
  end
  def join_params
    params.require(:join).permit(:idea_id)
  end
end
