class IdeasController < ApplicationController
  before_action :redirect_to_top
  before_action :set_idea, only: [:edit, :update, :show, :sort]

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
    @idea.memos.build
  end

  def create
    idea = Idea.create(idea_params)
    redirect_to controller: 'ideas', action: 'index'
  end

  def edit
    @memos = @idea.memos.rank(:row_order)
  end

  def update
    @idea.update(idea_params)
    redirect_to root_path
  end

  def show
    @memos = @idea.memos.includes(:user).rank(:row_order)
  end

  private
  def idea_params
    params.require(:idea).permit(
      :title, 
      :content, 
      memos_attributes: [:id, :content, :user_id, :row_order_position, :_destroy]
    )
    .merge(user_id: current_user.id)
  end

  def redirect_to_top
    redirect_to controller: :top, action: :index unless user_signed_in?
  end

  def set_idea
    @idea = Idea.find(params[:id])
  end

end
