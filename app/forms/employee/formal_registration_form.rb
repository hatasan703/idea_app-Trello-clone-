class Employee::FormalRegistrationForm
  include ActiveModel::Model

  attr_accessor :email,:password,:company_id,:token
  def initialize(attributes={})
    super
    @omg ||= true
  end
  # def find
  #   tokens=InvitingManagement.find_by(token:token)
  # end
  def save
    company_id_from_token = InvitingManagement.find_by(token:token)
    company_id =company_id_from_token.company_id
    new_user = User.new(email:email,password:password)
    new_user.tap(&:save)
    employee= Employee.new(company_id:company_id,user_id:new_user.id)
    if employee.tap(&:save)
      company_id_from_token.destroy
    end
  end
end
