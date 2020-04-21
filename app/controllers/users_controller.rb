class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @company_id = params[:company_id]
    @ideas = @user.ideas.where(company_id: @company_id)
    unless @user.admin?(current_user, @company_id)
      redirect_to root_path
    end
  end
  
end
