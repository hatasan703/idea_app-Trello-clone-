class Companies::FormalRegistrationsController < ApplicationController
  def new
    @form = Employee::FormalRegistrationForm.new
    puts params[:token]
    # @form.company_id=InvitingManagement.find_by(token:params[:token]).company_id
  end

  def create
    @data =Employee::FormalRegistrationForm.new(formal_registration_form_params)
    puts params[:token]
    if @data.save
      redirect_to authenticated_root_path
    else
      logger.debug @data.errors.inspect
      redirect_to new_user_registration
    end
  end

  private
  def formal_registration_form_params
    params.require(:employee_formal_registration_form).permit(:email,:password,:token)
  end
end
