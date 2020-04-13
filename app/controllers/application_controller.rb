class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    new_company_path
  end

  def after_sign_in_path_for(resource)
    companies_path
  end
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # :inviteと:accept_invitationに:nameを許可する
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end

  # Vueに渡すデータ
  def shared_data
    @shared_data ||= {}
  end
  helper_method :shared_data

end
