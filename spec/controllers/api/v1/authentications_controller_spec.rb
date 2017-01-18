require 'rails_helper'

RSpec.describe API::V1::AuthenticationsController, type: :controller do

  before do
    @request.headers['Content-Type'] = 'application/vnd.time4kids+json,application/json'
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_params) do
        {
          'user':{
            'email': 'john@doe.com',
            'password': 'qwerty123'
          }
        }
      end

      it 'return a valid jwt token' do
        post :create, valid_params
        expect(User.count).to eq(1)
      end
    end
  end
end
