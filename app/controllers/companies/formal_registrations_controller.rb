class Companies::FormalRegistrationsController < ApplicationController
  def new
    @form = Employee::FormalRegistrationForm.new
    # @form.company_id=InvitingManagement.find_by(token:params[:token]).company_id
  end

  def create
    @data =Employee::FormalRegistrationForm.new(isamu_params)
    if @data.save
      redirect_to authenticated_root
    else
      redirect_to new_user_registration
    end
  end

  private
  def isamu_params
    params.require(:employee_formal_registration_form).permit(:email,:password)
  end
end
