class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, invite_for: 24.hours
  has_many :ideas, ->{ order(position: :asc)  }, dependent: :destroy
  has_many :plans
  has_many :memos
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :members
  has_many :groups ,through: :members
  has_many :employees
  has_many :companies ,through: :employees

  attr_accessor :invitation_instructions
  attr_reader :raw_invitation_token

  def self.invite_guest!(attributes={}, invited_by=nil, company_id)
    self.invite!(attributes, invited_by, company_id)
  end
end
