# frozen_string_literal: true

class StudentProfile < ApplicationRecord
  has_one :user, as: :profile, dependent: :delete
  has_one :address
end
