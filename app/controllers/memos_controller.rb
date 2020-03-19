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
    respond_to do |format|
      if @memo.save
        format.html { redirect_to @memo, notice: 'Memo was successfully created.' }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.id == @memo.user_id
      respond_to do |format|
        if @memo.update(memo_params)
          format.html { redirect_to @memo, notice: 'Memo was successfully updated.' }
          format.json { render :show, status: :ok, location: @memo }
        else
          format.html { render :edit }
          format.json { render json: @memo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if current_user.id == @memo.user_id
      @memo.destroy
      respond_to do |format|
        format.html { redirect_to memos_url, notice: 'memo was successfully destroyed.' }
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