class Group < ApplicationRecord
  has_many :members
  # has_many :members, -> () { where(admin: false) }
  # has_many :members, -> () { where(admin: false) }

  has_many :users, through: :members
  accepts_nested_attributes_for :members, allow_destroy: true
  # has_many :user_admins,->{ select("#{User.table_name}.*", "#{Member.table_name}.order AS order") },
           # through: :members,
           # source: 'Users'
  # has_many :user_types ,through: :members
end
