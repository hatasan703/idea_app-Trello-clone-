class IdeasController < ApplicationController
  before_action :redirect_to_top

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.create(idea_params)
    
    redirect_to action: :index
  end

  def show
    @idea = Idea.find(params[:id])
    @idea_memo = IdeaMemo.new
    @idea_memos = @idea.idea_memos.includes(:user)
  end


  private
  def idea_params
    params.require(:idea).permit(:title, :content).merge(user_id: current_user.id)
  end
  def redirect_to_top
    redirect_to controller: :top, action: :index unless user_signed_in?
  end
end
