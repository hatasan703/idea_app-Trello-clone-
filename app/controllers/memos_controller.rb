class MemosController < ApplicationController
  def create
    @memo = Memo.create(memo_params)
    redirect_to idea_path(params[:idea_id])
  end

  def show
  end

  def sort
    memo = Memo.find(params[:memo_id])
    params[:idea_id] = memo.idea_id
    memo.update(memo_params)
    render body: nil 
  end

  private
  def memo_params
    params.require(:memo).permit(:content, :row_order_position).merge(idea_id: params[:idea_id], user_id: current_user.id)
  end
end