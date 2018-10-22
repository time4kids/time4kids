# frozen_string_literal: true

class SchoolProfile < ApplicationRecord
  has_one :user, as: :profile, dependent: :delete
  has_many :addresses, as: :addressable, dependent: :delete_all
  has_and_belongs_to_many :categories, optional: true

  accepts_nested_attributes_for :addresses

  validates :name, presence: true
  #TODO - remove if there will be no need in this validation
  # validates_associated :addresses

  api_accessible :v1_default do |t|
    t.add :id
    t.add :name
    t.add :website
    t.add :phone
    t.add :description
    t.add :addresses, as: :addressable
  end

  def assign_attributes(attrs)
    return super if !attrs[:address_attributes] || attrs[:address_attributes].empty?

    attrs.merge!(addresses_attributes: [attrs.delete(:address_attributes)])

    super(attrs)
  end
end
