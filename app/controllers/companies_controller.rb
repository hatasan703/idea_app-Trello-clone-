class CompaniesController < ApplicationController
  before_action :redirect_to_top
  def index
    @user = current_user
    @companies = @user.companies
  end

  def new
    @company = Company.new
    @company.employees.build
  end

  def create
    company = Company.create(company_params)
    redirect_to companies_path
  end

  private
  def company_params
    params.require(:company).permit(:name, employees_attributes:[:id, :user_id, :admin])
  end

  def redirect_to_top
    redirect_to new_user_session_path unless user_signed_in?
  end

end















