class CommentsController < ApplicationController

  before_action :set_comment, only: [:destroy]
  before_action :is_matched_user?, only: [:destroy]

  
  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to public_company_ideas_path(@company_id) }
        format.json { render :show, status: :created }
      else
        redirect_to public_company_ideas_path(c@ompany_id)
      end
    end
  end

  def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to public_company_ideas_path(@company_id) }
        format.json { head :no_content }
      end
  end


  private
  def comment_params
    params.require(:comment).permit(:idea_id, :content).merge(user_id: current_user.id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
    @company_id = Idea.find(params[:idea_id]).company_id
  end

  def is_matched_user?
    unless current_user.id == @comment.user_id
      redirect_to public_company_ideas_path(company_id)
    end
  end

end
