# frozen_string_literal: true

RSpec.configure do
  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        'coordinates'  => [Faker::Address.latitude, Faker::Address.longitude],
      }
    ]
  )
end
