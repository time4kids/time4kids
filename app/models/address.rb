# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, optional: true

  api_accessible :v1_default do |t|
    t.add :id
    t.add :country
    t.add :city
    t.add :number
    t.add :region
    t.add :street
    t.add :lat
    t.add :long
  end
end
