class PlansController < ApplicationController
  before_action :set_planning_page, only: [:new, :edit, :show]
  before_action :is_matched_user?, except: :show

  def new
    redirect_to edit_idea_plan_path(@idea, @plan) if @plan.present?
    @plan = Plan.new
    4.times do
      @plan.plan_contents.build
    end
  end

  def edit
    @plan_contents = @plan.plan_contents if @plan.present?
  end

  def show
  end

  def create
    @plans = Plan.create(plan_params)
    @idea_id = params[:idea_id]
    redirect_to edit_idea_plan_path(@idea_id, @plans)
  end

  def update
    @plan = Plan.update(plan_params)
    @idea_id = params[:idea_id]
    redirect_to edit_idea_plan_path(@idea_id, @plan)
  end

  private
  def plan_params
    params.require(:plan).permit(
      :image, 
      :user_id, 
      :idea_id, 
      plan_contents_attributes: [:id, :content, :user_id, :plan_question_id, :_destroy])
        .merge(
          user_id: current_user.id, 
          idea_id: params[:idea_id]
        )
  end

  def set_planning_page
    @num = 0
    @plan_questions = PlanQuestion.all
    @idea = Idea.find(params[:idea_id])
    @plan = @idea.plan
  end

  def is_matched_user?
    unless current_user.id == Idea.find(params[:idea_id]).user_id
      redirect_to root_path
    end
  end

end
