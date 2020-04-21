
class Users::SessionsController < Devise::SessionsController
  after_action :after_login, only: :create

  def create
    super
  end
  
  private

  def after_login
    current_user.update(current_sign_in_at: Time.current)
  end
end
