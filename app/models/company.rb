class Company < ApplicationRecord
  has_many :employees
  has_many :users, through: :employees
  accepts_nested_attributes_for :employees, allow_destroy: true
end
