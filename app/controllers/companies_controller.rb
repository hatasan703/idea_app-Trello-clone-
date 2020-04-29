class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy, :destroy_member]
  def index
    @user = current_user
    @companies = @user.companies
  end

  def show
    @users = @company.users
    unless @company.admin_user?(current_user)
      redirect_to root_path
    end
  end

  def new
    @company = Company.new
    @company.employees.build
  end

  def create
    company = Company.new(company_params)
    if company.save
      redirect_to company_ideas_path(company)
    else
      redirect_to companies_path
    end
  end

  def update
    if @company.admin_user?(current_user)
      @company.update(company_params)
      redirect_to company_ideas_path(@company)
    end
  end

  def destroy
    if @company.admin_user?(current_user)
      @company.destroy
      redirect_to root_path
    end
  end

  def destroy_member
    employee = @company.remove_employee(current_user, params[:user_id])
    employee.destroy if employee
    redirect_to company_ideas_path(@company)
  end

  private
  def company_params
    params.require(:company).permit(:name, employees_attributes:[:id, :user_id, :admin])
  end

  def set_company
    @company = Company.find(params[:id])
  end
end















