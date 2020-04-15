class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :user

  def self.join_to_company(company_id, user_id)
    self.create(company_id: company_id, user_id: user_id)
  end
end
