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
  has_one :profile
  accepts_nested_attributes_for :profile

  attr_accessor :invitation_instructions
  attr_reader :raw_invitation_token

  def self.invite_user!(attributes={}, invited_by=nil, company_id)
    self.invite!(attributes, invited_by, company_id)
  end

  def update_after_invite
    if self.errors.empty?
      self.update_column :invitation_sent_at, Time.now.utc
    end
  end

  def invited_judg(company_id)
    if self.companies.find_by(id: company_id).nil?
      true
    else
      false
    end
  end

end