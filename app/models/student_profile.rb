# frozen_string_literal: true

class StudentProfile < ApplicationRecord
  has_one :user, as: :profile, dependent: :delete
  has_one :address

  api_accessible :v1_default do |t|
    t.add :id
    # t.add :address
    t.add :age
    t.add :phone
  end
end
