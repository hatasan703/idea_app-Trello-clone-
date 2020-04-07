class Companies::DashbordsController < ApplicationController
  def index
    @User = current_company.users
  end
  def show
    @information = InvitingManagement.find(params[:id])
  end
  def new
    @form = Employee::SignUpForm.new
  end
  def create
    puts maeno_params
    @data = Employee::SignUpForm.new(maeno_params)
    result = @data.save
    if result
      puts result.token
      redirect_to companies_dashbord_path(result.id)
    else
      redirect_to root_path
    end
  end

  private

  def maeno_params
    params.require(:employee_sign_up_form).permit(:company_id)
  end
end
