class Companies::DashbordsController < ApplicationController
  before_action :authenticate_company!
  def index
    #@User = current_company.users
  end
  def show
    @information = InvitingManagement.find(params[:id])
  end
  def new
    @form = Employee::SignUpForm.new
  end
  def create
    puts company_params
    @data = Employee::SignUpForm.new(company_params)
    result = @data.save
    if result
      puts result.token
      redirect_to companies_dashbord_path(result.id)
    else
      redirect_to root_path
    end
  end

  private

  def company_params
    params.require(:employee_sign_up_form).permit(:company_id)
  end
end
