class Plan < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :idea
  has_many :plan_contents
  accepts_nested_attributes_for :plan_contents, allow_destroy: true

end
