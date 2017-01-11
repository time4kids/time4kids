module API
  module V1
    class AuthenticationController < ::API::V1::ApiController
      before_action :authenticate

      def create
        render json: auth_token, status: :created
      end

      private

      def authenticate
        if !entity.present? || !entity.valid_password?(login_params[:password])
          raise API::Exception.new('auth.invalid_credentials', code: 401)
        end
      end

      def auth_token
        API::JWTAdapter.encode(user_id: entity.id)
      end

      def entity
        @entity ||=
          User.find_for_database_authentication(email: login_params[:email])
      end

      def login_params
        params.require(:data).permit(:email, :password)
      rescue ActionController::ParameterMissing
        raise API::Exception.new('request.invalid_params', code: 422)
      end
    end
  end
end
