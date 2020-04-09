class CompaniesController < ApplicationController
  def index
  end

  def new
    @company = Company.new
  end

  def create_a
    binding.pry
    Company.create(company_params)
    redirect_to companies_path
  end

  def company_params
    params.require(:company).permit(:name, {users_id: []})
  end

end
