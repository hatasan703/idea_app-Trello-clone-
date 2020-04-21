class Company < ApplicationRecord
  has_many :employees
  has_many :users, through: :employees
  has_many :ideas
  accepts_nested_attributes_for :employees, allow_destroy: true
  
  def admin_user?(current_user)
    if current_user.employees.find_by(company_id: self.id).admin == true
      true
    else
      false
    end
  end

  def remove_employee(current_user, id)
    if current_user.employees.find_by(company_id: self.id).admin == true
       self.employees.find_by(user_id: id)
    else
      false
    end
  end

end
