# frozen_string_literal: true

class Category < ApplicationRecord
  has_and_belongs_to_many :school_profiles, optional: true, join_table: 'school_categories'

  api_accessible :v1_default do |t|
    t.add :id
    t.add :name
  end
end
