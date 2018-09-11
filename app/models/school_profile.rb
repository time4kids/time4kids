# frozen_string_literal: true

class SchoolProfile < ApplicationRecord
  has_one :user, as: :profile, dependent: :delete
  has_many :addresses

  validates :name, presence: true

  api_accessible :v1_default do |t|
    t.add :id
    t.add :name
    t.add :website
    t.add :phone
    t.add :description
  end
end
