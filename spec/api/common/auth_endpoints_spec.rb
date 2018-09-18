# frozen_string_literal: true

require 'rails_helper'

describe '/auth (common)' do
  describe '/login' do
    describe 'POST /' do
      it 'fails for missing user' do
        post '/v1/auth/login', params: { user: { email: 'test@test.com', password: 'p@ssword' } }

        expect_status(401)
        expect_json_types('error', message: :string)
        expect_json('error.message', 'You need to sign in or sign up before continuing.')
      end

      it 'passes for correct Email' do
        post '/v1/auth/login', params: { email: User.students.first.email, password: 'p@ssword' }
        expect_status(201)
        expect_json_types(token: :string, user: STUDENT)
      end
    end
  end

  describe '/logout' do
    describe 'DELETE /:id' do
      skip 'deletes existing session' do
        with_auth(expect_401: false) do |args|
          delete '/v1/auth/logout', args
          expect_status(200)
          expect_json(success: true)
        end

        with_auth(expect_200: false) do |args|
          get '/v1/profile', args
          expect_status(401)
          expect_json_types(error: { message: :string })
        end
      end
    end

    describe 'POST /' do
      skip 'also deletes existing session' do
        with_auth(expect_401: false) do |args|
          post '/v1/auth/logout', args
          expect_status(200)
          expect_json(success: true)
        end

        with_auth(expect_200: false) do |args|
          get '/v1/profile', args
          expect_status(401)
          expect_json_types(error: { message: :string })
        end
      end
    end
  end
end
