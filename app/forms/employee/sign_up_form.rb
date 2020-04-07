class Employee::SignUpForm
  include ActiveModel::Model
  require 'securerandom'

  attr_accessor :company_id
  def initialize(attributes={})
    super
    @omg ||= true
  end
  def save
    token =SecureRandom.hex(8)
    puts token
    inviting_user = InvitingManagement.new(company_id:company_id,token:token)
    inviting_user.tap(&:save)
  end
end
