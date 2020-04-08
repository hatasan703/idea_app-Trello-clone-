class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    puts resource
    if resource.is_a?(Company)
      companies_dashbords_path
    else
      ideas_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # Vue渡すデータ
  def shared_data
    @shared_data ||= {}
  end
  helper_method :shared_data

end
