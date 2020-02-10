class IdeaMemosController < ApplicationController

  def create
    @idea_memo = IdeaMemo.create(idea_memo_params)
    redirect_to idea_path(params[:idea_id])
  end

  private
  def idea_memo_params
    params.require(:idea_memo).permit(:content).merge(idea_id: params[:idea_id], user_id: current_user.id)
  end
end
