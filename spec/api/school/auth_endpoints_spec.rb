# frozen_string_literal: true

require 'rails_helper'

describe '/auth (school)' do
  let(:avatar) { fixture_file_upload('valid_image.jpeg', 'image/jpeg') }
  let(:address) {
    {
      country: Faker::Address.country,
      region: Faker::Address.state,
      city: Faker::Address.city,
      street: Faker::Address.street_name,
      number: Faker::Address.building_number,
      postal_code: Faker::Address.postcode
    }
  }

  describe 'POST /register' do
    before do
      @new_school = {
        email: 'test@test.com',
        password: 'p@ssword',
        password_repeat: 'p@ssword',
        first_name: 'Pablo',
        last_name: 'Picasso',
        avatar: avatar,
        role: 'school',
        profile: {
          name: 'Test school 1',
          phone: Faker::PhoneNumber.cell_phone,
          website: 'http://blabla.com',
          description: Faker::Lorem.paragraph,
          address: address
        }
      }
    end

    it 'fails for missing Email' do
      post '/v1/auth/register', params: { user: @new_school.except(:email) }

      expect_status(422)
      expect_json_types('error', message: :string)
      expect_json('error.message', "Email can't be blank")
    end

    it 'fails for existing Email' do
      @new_school[:email] = User.schools.first.email

      post '/v1/auth/register', params: { user: @new_school }

      expect_status(422)
      expect_json_types('error', message: :string)
    end

    it 'passes for correct new school' do
      post '/v1/auth/register', params: { user: @new_school }

      expect_status(201)
      expect_json_types(token: :string, user: SCHOOL)
      expect_json_types('user.profile.addressable.*', ADDRESS)

      user = JSON.parse(response.body)['user']
      expect(user['avatar']).to_not be_empty
    end

    it 'passes for missing avatar' do
      @new_school[:avatar] = nil
      post '/v1/auth/register', params: { user: @new_school }
      expect_status(201)
      expect_json_types(token: :string, user: SCHOOL)

      user = JSON.parse(response.body)['user']
      expect(user['avatar']).to be_empty
    end

    it 'passes for missing address' do
      @new_school[:profile][:address] = nil
      post '/v1/auth/register', params: { user: @new_school }

      expect_status(201)
      expect_json_types(token: :string, user: SCHOOL)

      user = JSON.parse(response.body)['user']
      expect(user['profile']['addressabe']).to be_nil
    end

    it 'returns correct error for invalid avatar' do
      @new_school[:avatar] = fixture_file_upload('.keep')

      post '/v1/auth/register', params: { user: @new_school }

      expect_status(422)
      expect_json_types('error', message: :string)
    end

    it 'passes for missing profile data' do
      @new_school[:avatar] = nil
      post '/v1/auth/register', params: { user: @new_school.except(:profile) }
      expect_status(201)

      expect_json_types(token: :string, user: USER)

      user = JSON.parse(response.body)['user']
      expect(user['profile']).to be_nil
    end
  end

  describe 'PUT /register' do
    context 'confirmed school' do
      before do
        @current_user = User.find_by_email('incomplete@example.com')
        auth_for(@current_user)
      end

      it 'should update school profile' do
        updates = {
          first_name: 'MODIFIED',
          profile: {
            name: 'Complete profile',
            phone: Faker::PhoneNumber.cell_phone,
            website: 'http://blabla.com',
            description: Faker::Lorem.paragraph,
            address: address
          }
        }

        expect(@current_user.profile).to be_nil

        with_auth(expect_200: false) { |args|
          put '/v1/auth/register', args.merge(params: { user: updates })
        }

        expect(response.status).to be 204
        expect(@current_user.reload.profile).to_not be_nil
      end
    end

    context 'unconfirmed school' do
      before do
        @current_user = User.find_by_email('unconfirmedschool@example.com')
        auth_for(@current_user)
      end

      it 'should fail update school profile' do
        updates = {
          first_name: 'MODIFIED',
          profile: {
            gender: 'f',
            phone: Faker::PhoneNumber.cell_phone,
            age: 32
          }
        }

        with_auth(expect_200: false) { |args|
          put '/v1/auth/register', args.merge(params: { user: updates })
        }

        expect(response.status).to be 401
      end
    end
  end
end
