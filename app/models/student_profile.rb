# frozen_string_literal: true

class StudentProfile < ApplicationRecord
  has_one :user, as: :profile, dependent: :delete
  has_one :address, as: :addressable, dependent: :delete

  accepts_nested_attributes_for :address

  api_accessible :v1_default do |t|
    t.add :id
    t.add :age
    t.add :phone
    t.add :gender
    t.add :address, as: :addressabe
  end
end
