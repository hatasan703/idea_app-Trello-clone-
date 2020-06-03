
class Users::RegistrationsController < Devise::RegistrationsController
  after_action :after_sign_up, only: :create

  def create
    super
  end
  
  private

  def after_sign_up
    current_user.update(current_sign_in_at: Time.current)
  end
end
