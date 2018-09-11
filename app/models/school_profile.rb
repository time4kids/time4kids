class SchoolProfile < ApplicationRecord
  has_one :user, as: :profile
  has_many :addresses

  validates :name, presence: true

  accepts_nested_attributes_for :addresses
end
