class Employee::FormalRegistrationForm
  include ActiveModel::Model

  attr_accessor :email,:password,:company_id
  def initialize(attributes={})
    super
    @omg ||= true
  end
  # def find
  #   tokens=InvitingManagement.find_by(token:token)
  # end
  def save
    password =password(password)
    new_user = User.new(email:email,encrypted_password:password)
    new_user.tap(&:save)
    employee= Employee.new(company_id:company_id,user_id:new_user.id)
  end
  private
  def password(raw_pass)
    if raw_pass.kind_of?(String)
      self.encrypted_password = BCrypt::Password.create(raw_pass)
    elsif raw_pass.nil?
      self.encrypted_password = nil
    end
  end
end
