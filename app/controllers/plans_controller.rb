class PlansController < ApplicationController
  before_action :redirect_to_top
  before_action :set_planning_page, only: [:new, :edit]

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

  def redirect_to_top
    redirect_to controller: :top, action: :index unless user_signed_in?
  end

  def set_planning_page
    @num = 0
    @plan_questions = PlanQuestion.all
    @idea = Idea.find(params[:idea_id])
    @plan = Plan.find_by(idea_id: @idea.id)
  end


end
