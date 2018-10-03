# frozen_string_literal: true

class Address < ApplicationRecord
  geocoded_by :full_address, latitude: :lat, longitude: :long

  belongs_to :addressable, polymorphic: true, optional: true

  after_validation :geocode, if: ->(obj) { obj.full_address.present? and obj.changed? }

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

  def full_address
    [[street, number].join(' '), postal_code, city, region, country].join(', ')
  end
end
