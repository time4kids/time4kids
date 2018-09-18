# frozen_string_literal: true

require 'rails_helper'

describe '/auth (student)' do
  let(:avatar) { fixture_file_upload('valid_image.jpeg', 'image/jpeg') }

  describe 'POST /register' do
    before do
      @new_student = {
        email: 'test@test.com',
        password: 'p@ssword',
        password_repeat: 'p@ssword',
        first_name: 'Pablo',
        last_name: 'Picasso',
        avatar: avatar,
        role: 'student',
        profile: {
          phone: Faker::PhoneNumber.cell_phone,
          address: Faker::Address.full_address,
          age: 16
        }
      }
    end

    it 'fails for missing Email' do
      post '/v1/auth/register', params: { user: @new_student.except(:email) }

      expect_status(422)
      expect_json_types('error', message: :string)
      expect_json('error.message', "Email can't be blank")
    end

    it 'fails for existing Email' do
      @new_student[:email] = User.students.first.email

      post '/v1/auth/register', params: { user: @new_student }

      expect_status(422)
      expect_json_types('error', message: :string)
    end

    it 'passes for correct new school' do
      post '/v1/auth/register', params: { user: @new_student }
      expect_status(201)
      expect_json_types(token: :string, user: STUDENT)

      user = JSON.parse(response.body)['user']
      expect(user['avatar']).to_not be_empty
    end

    it 'passes for missing avatar' do
      @new_student[:avatar] = nil
      post '/v1/auth/register', params: { user: @new_student }
      expect_status(201)

      expect_json_types(token: :string, user: STUDENT)

      user = JSON.parse(response.body)['user']
      expect(user['avatar']).to be_empty
    end

    it 'returns correct error for invalid avatar' do
      @new_student[:avatar] = fixture_file_upload('.keep')

      post '/v1/auth/register', params: { user: @new_student }

      expect_status(422)
      expect_json_types('error', message: :string)
    end

    it 'passes for missing profile data' do
      @new_student[:avatar] = nil
      post '/v1/auth/register', params: { user: @new_student.except(:profile) }
      expect_status(201)

      expect_json_types(token: :string, user: USER)

      user = JSON.parse(response.body)['user']
      expect(user['profile']).to be_nil
    end
  end
end
