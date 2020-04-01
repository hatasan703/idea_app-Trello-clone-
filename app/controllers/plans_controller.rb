class PlansController < ApplicationController
  # before_action :set_plan, only: [:index]

  def index
    @plan_questions = PlanQuestion.all
    @idea = Idea.find(params[:idea_id])
    @plan = Plan.find_by(idea_id: @idea.id)
    @plan_contents = @plan.plan_contents if @plan.present?
    if @plan.nil?
      @plan = Plan.new
      4.times do
        @plan.plan_contents.build
      end
    end
  end

  def create
    @plans = Plan.create(plan_params)
    redirect_to idea_plans_path
  end

  def update
    binding.pry
    @plan = Plan.update(plan_params)
    redirect_to idea_plans_path
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

  # def redirect_to_top
  #   redirect_to controller: :top, action: :index unless user_signed_in?
  # end

  def set_plan
    @plan = Plan.find(params[:id])
  end


end
