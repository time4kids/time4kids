USER = {
  id: :integer,
  role: :string,
  email: :string,
  first_name: :string,
  last_name: :string,
  avatar: :string,
  gender: :string_or_null,
  is_active: :boolean
}

SCHOOL_PROFILE = {
  # address: ADDRESS,
  id: :integer,
  name: :string,
  website: :string_or_null,
  phone: :string_or_null,
  description: :string
}.freeze

SCHOOL = USER.merge(profile: SCHOOL_PROFILE)

ADDRESS = {
  country: :string,
  city: :string,
  street: :string,
  number: :string,
  region: :string_or_null,
  lat: :float_or_null,
  long: :float_or_null
}.freeze
