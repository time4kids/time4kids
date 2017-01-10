module API
  module V1
    class AuthenticationController < ::API::V1::ApiController
      before_action :authenticate

      def create
        render json: auth_token, status: :created
      end

      private

      def authenticate
        if !entity.present? && !entity.valid_password?(params[:password])
          head :not_found
        end
      end

      def auth_token
        API::JWTAdapter.encode(user_id: entity.uuid)
      end

      def entity
        @entity ||=
          User.find_for_database_authentication(email: params[:email])
      end
    end
  end
end
