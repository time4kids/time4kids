module API
  module V1
    class RegistrationController < ::API::V1::ApiController
      before_action :authenticate_user

      def create
        user = User.new(sign_up_params)

        if user.save
          tk = Knock::AuthToken.new payload: { sub: user.id }
          render json: { token: tk.token }, status: 201
        else
          warden.custom_failure!
          render json: user.errors, status: 422
        end
      end

      private

      def sign_up_params
        params.require(:user).permit([
          :email,
          :password,
          :password_confirmation,
          :first_name,
          :last_name
        ])
      end
    end
  end
end
