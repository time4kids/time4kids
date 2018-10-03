# frozen_string_literal: true
require 'devise/jwt/test_helpers'

TEST_VALUE = 'TEST_VALUE'
MODIFIED = 'MODIFIED'
VERSION = :v1

def as_api(resource, api_template = :"#{VERSION}_default")
  hash = resource.as_api_response(api_template)
  # Originally dates are objects in as_api_response, so comparision fails
  JSON.parse(hash.to_json, symbolize_names: true)
end

def debug_response
  puts "Status: #{response.status}"
  puts response.body
end

def result
  JSON.parse(response.body).with_indifferent_access
end

def auth_for(user)
  headers = { 'Accept' => 'application/json', 'Content_Type' => 'application/json' }
  # This will add a valid token for `user` in the `Authorization` header
  @auth_header = Devise::JWT::TestHelpers.auth_headers(headers, user)
end

def with_auth(expect_200: true, expect_401: true)
  yield({})
  if expect_401
    expect_status(401)
    expect_json('error.message', 'You need to sign in or sign up before continuing.')
  end

  yield({ headers: @auth_header })
  if expect_200
    if response.status != 200
      debug_response
    end

    expect_status(200)
  end
end

def expect_json_scheme(path, scheme)
  expect_json_types(path, scheme)
  expect_json_keys(path, scheme.keys)
end

def expect_sorted_by(collection, desc = nil, &block)
  sorted = collection.sort_by(&block)
  expect(collection).to eq(desc ? sorted.reverse : sorted)
end

def expect_success_with_id
  expect_json(success: true)
  expect_json_types(id: :integer)
end

def stub_gecoding(address)
  Geocoder::Lookup::Test.add_stub(
    address, [
      {
        'coordinates'  => [Faker::Address.latitude, Faker::Address.longitude],
      }
    ]
  )
end
