class CompaniesController < ApplicationController
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

  def company_params
    params.require(:company).permit(:name, employees_attributes:[:id, :user_id, :admin])
  end

end















