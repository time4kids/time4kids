module API
  module V1
    class AuthenticationsController < ::Devise::SessionsController
      include API::ErrorsHandler

      # Disable CSRF protection
      skip_before_action :verify_authenticity_token

      respond_to :json

      # POST /api/v1/authentication
      def create
        self.resource = warden.authenticate(auth_options)
        if self.resource
          sign_in resource, store: false

          render json: resource, serializer: SessionSerializer, status: :created
        else
          raise API::Exception.new('auth.invalid_credentials', code: 401)
        end
      end
    end
  end
end
