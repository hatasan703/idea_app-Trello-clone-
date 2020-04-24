class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy, :move]

  def index
    @memos = Memo.sorted
  end

  def new
    @memo = Memo.new
  end
  
  def create
    @memo = Memo.new(memo_params)
    company_id = Idea.find(params[:memo][:idea_id]).company_id
    respond_to do |format|
      if @memo.save
        format.html { redirect_to company_ideas_path(company_id) }
        format.json { render :show, status: :created, location: @memo }
      else
        redirect_to company_ideas_path(company_id)
      end
    end
  end

  def update
    company_id = Idea.find(@memo.idea_id).company_id
    if current_user.id == @memo.user_id
      respond_to do |format|
        if @memo.update(memo_params)
          format.html { redirect_to company_ideas_path(company_id) }
          format.json { render :show, status: :ok, location: @memo }
        else
          redirect_to company_ideas_path(company_id)
        end
      end
    end
  end

  def destroy
    company_id = Idea.find(@memo.idea_id).company_id
    if current_user.id == @memo.user_id
      @memo.destroy
      respond_to do |format|
        format.html { redirect_to company_ideas_path(company_id) }
        format.json { head :no_content }
      end
    end
  end

  def move
    if current_user.id == @memo.user_id
      @memo.update(memo_params)
      render action: :show
    end
  end



  private
  def set_memo
    @memo = Memo.find(params[:id])
  end

  def sort
    memo = Memo.find(params[:memo_id])
    params[:idea_id] = memo.idea_id
    memo.update(memo_params)
    render body: nil 
  end

  def memo_params
    params.require(:memo).permit(:idea_id, :content, :position).merge(user_id: current_user.id)
  end

end