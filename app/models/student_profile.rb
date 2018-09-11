class StudentProfile < ApplicationRecord
  has_one :user, as: :profile
  has_one :address

  accepts_nested_attributes_for :address
end
