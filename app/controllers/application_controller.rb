class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    ideas_path
  end

  def shared_data
    @shared_data ||= {}
  end
  helper_method :shared_data
  
end
