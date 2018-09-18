# frozen_string_literal: true

require 'rails_helper'

describe '/auth (school)' do
  let(:avatar) { fixture_file_upload('valid_image.jpeg', 'image/jpeg') }

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
          description: Faker::Lorem.paragraph
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
    before do
      @current_user = User.find_by_email('incomplete@example.com')
      auth_for(@current_user)
    end

    it 'update school profile' do
      updates = {
        first_name: 'MODIFIED',
        profile: {
          name: 'Complete profile',
          phone: Faker::PhoneNumber.cell_phone,
          website: 'http://blabla.com',
          description: Faker::Lorem.paragraph
        }
      }

      expect(@current_user.profile).to be_nil

      with_auth { |args| put '/v1/auth/register', args.merge(params: { user: updates }) }

      expect(@current_user.reload.profile).to_not be_nil

      expect_json_scheme('user', SCHOOL)
      # expect_json(user: updates.deep_merge({ profile: { gender: unmodified_gender } }))
      expect_json_scheme('user.profile.*', SCHOOL_PROFILE)
    end
  end
end
