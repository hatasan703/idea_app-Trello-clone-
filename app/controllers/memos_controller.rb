class MemosController < ApplicationController
  def create
    @memo = Memo.create(memo_params)
    redirect_to idea_path(params[:idea_id])
  end

  # def show
  # end

  # def edit
  #   @idea = Idea.find(params[:idea_id])
  #   @memo = Memo.find(params[:id])
  #   @memos = @idea.memos.rank(:row_order)
  # end

  # def update
  #   @memo = Memo.find(memo_params)
  #   @memo.update(memo_params)

  #   respond_to do |format|
  #     if @memo.save
  #       format.html { redirect_to @memo, notice: 'memo was successfully created.' }
  #       format.json { render :show, status: :created, location: @memo }
  #       format.js { @status = "success" }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @memo.errors, status: :unprocessable_entity }
  #       format.js { @status = "fail" }
  #     end
  #   end
  # end

  # def destroy
  #   memo = Memo.find(params[:id])
  #   memo.destroy if memo.user_id == current_user.id
  #   redirect_to idea_path(memo.idea_id)
  # end

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