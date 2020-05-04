class PlanCommentsController < ApplicationController

  def create
    @comment = PlanComment.create(comment_params)
    plan_id = params[:plan_id]
    idea_id = Plan.find(plan_id).idea_id
    redirect_to idea_plan_path(idea_id, plan_id)
  end

  def destroy
  end

  private
  def comment_params
    params.require(:plan_comment).permit(:content).merge(
      user_id: current_user.id,
       plan_id: params[:plan_id],
      )
  end

end