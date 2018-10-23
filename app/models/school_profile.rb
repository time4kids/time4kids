# frozen_string_literal: true

class SchoolProfile < ApplicationRecord
  has_one :user, as: :profile, dependent: :delete, inverse_of: :profile
  has_many :addresses, as: :addressable, dependent: :delete_all, inverse_of: :addressable
  has_and_belongs_to_many :categories, optional: true, join_table: 'school_categories'

  accepts_nested_attributes_for :addresses

  validates :name, :phone, presence: true, allow_blank: false

  # validates_presence_of :addresses

  api_accessible :v1_default do |t|
    t.add :id
    t.add :name
    t.add :website
    t.add :phone
    t.add :description
    t.add :addresses, as: :addressable
    t.add :categories, template: :v1_default
  end

  def assign_attributes(attrs)
    return super unless attrs[:address_attributes].presence
    address_attributes = if attrs[:address_attributes].is_a?(Array)
                           attrs.delete(:address_attributes)
                         else
                           [attrs.delete(:address_attributes)]
                          end

    attrs[:addresses_attributes] = address_attributes
    super(attrs)
  end
end
