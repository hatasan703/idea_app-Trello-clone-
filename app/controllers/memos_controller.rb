class MemosController < ApplicationController
  def create
    @memo = Memo.create(memo_params)
    redirect_to idea_path(params[:idea_id])
  end

  def show

  end

  private
  def memo_params
    params.require(:memo).permit(:content).merge(idea_id: params[:idea_id], user_id: current_user.id)
  end
end
