# frozen_string_literal: true

USER = {
  id: :integer,
  role: :string,
  email: :string,
  first_name: :string,
  last_name: :string,
  avatar: :string,
  gender: :string_or_null,
  is_active: :boolean
}.freeze

SCHOOL_PROFILE = {
  # address: ADDRESS,
  id: :integer,
  name: :string,
  website: :string_or_null,
  phone: :string_or_null,
  description: :string
}.freeze

STUDENT_PROFILE = {
  # address: ADDRESS,
  id: :integer,
  phone: :string_or_null,
  age: :integer_or_null
}.freeze

SCHOOL = USER.merge(profile: SCHOOL_PROFILE)
STUDENT = USER.merge(profile: STUDENT_PROFILE)

ADDRESS = {
  country: :string,
  city: :string,
  street: :string,
  number: :string,
  region: :string_or_null,
  lat: :float_or_null,
  long: :float_or_null
}.freeze
