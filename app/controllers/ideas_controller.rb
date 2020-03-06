class IdeasController < ApplicationController
  before_action :redirect_to_top
  before_action :set_idea, only: [:edit, :update, :show, :destroy, :move]


  def index
    @ideas = Idea.sorted
  end

  def show
    @memos = @idea.memos.includes(:user).rank(:row_order)
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @memos = @idea.memos.rank(:row_order)
  end

  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move
    @idea.insert_at(idea_params[:position].to_i)
    render action: :show
  end

  private
  def idea_params
    params.require(:idea).permit(:content, :position)
    .merge(user_id: current_user.id)
  end

  def redirect_to_top
    redirect_to controller: :top, action: :index unless user_signed_in?
  end

  def set_idea
    @idea = Idea.find(params[:id])
  end

end
