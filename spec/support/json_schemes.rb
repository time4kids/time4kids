# frozen_string_literal: true

ADDRESS = {
  id: :integer,
  country: :string,
  city: :string,
  number: :string,
  region: :string_or_null,
  street: :string,
  lat: :float_or_null,
  long: :float_or_null
}.freeze

USER = {
  id: :integer,
  role: :string,
  email: :string,
  first_name: :string,
  last_name: :string,
  avatar: :string,
  is_active: :boolean
}.freeze

SCHOOL_PROFILE = {
  id: :integer,
  name: :string,
  website: :string_or_null,
  phone: :string_or_null,
  description: :string,
  addressable: :array_of_objects_or_null
}.freeze

STUDENT_PROFILE = {
  addressable: :object_or_null,
  id: :integer,
  phone: :string_or_null,
  age: :integer_or_null,
  gender: :string_or_null
}.freeze

SCHOOL = USER.merge(profile: SCHOOL_PROFILE)
STUDENT = USER.merge(profile: STUDENT_PROFILE)
