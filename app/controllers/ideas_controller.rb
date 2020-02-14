class IdeasController < ApplicationController
  before_action :redirect_to_top
  before_action :set_idea, only: [:edit]

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
    @idea = Idea.find(params[:id])
    @memos = @idea.memos.includes(:user)
  end

  def update
    idea = Idea.update(idea_params)
    redirect_to edit_idea_path(idea)
  end

  def show
  end

  private
  
  def idea_params
    params.require(:idea).permit(
      :title, 
      :content, 
      memos_attributes: [:id, :content, :_destroy, :user_id]
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
