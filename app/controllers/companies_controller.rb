class CompaniesController < ApplicationController
  def index
    @user = current_user
    @companies = @user.companies
  end

  def new
    @company = Company.new
  end

  def create
    @user = current_user
    @user.companies.create(company_params)
    redirect_to companies_path
  end

  def company_params
    params.require(:company).permit(:name)
  end

end
