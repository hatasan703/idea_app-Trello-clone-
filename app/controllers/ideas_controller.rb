class IdeasController < ApplicationController
  # before_action :redirect_to_top

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
    @idea.memos.build
  end

  def create
    idea = Idea.create!(idea_params)
    # idea = Idea.new(idea_params)
    # idea.save
    redirect_to controller: 'ideas', action: 'index'
  end

  def show
    @idea = Idea.find(params[:id])
    @memo = Memo.new
    @memos = @idea.memos.includes(:user)
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
end
