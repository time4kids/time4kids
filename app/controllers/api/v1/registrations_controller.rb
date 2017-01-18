module API
  module V1
    class RegistrationsController < ::Devise::RegistrationsController
      skip_before_action :verify_authenticity_token

      respond_to :json

      def create
        super do |resource|
          if resource.valid?
            sign_in resource, store: false
            render json: resource, serializer: SessionSerializer, status: 201
          else
            render json: resource.errors, status: 422
          end
          return
        end
      end

      def update
        super do |resource|
          if resource.valid?
            render nothing: true, status: 204
          else
            render json: resource.errors, status: 422
          end
          return
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email,
                                     :password, :password_confirmation)
      end

      def account_update_params
        params.require(:user).permit(:first_name, :last_name,
                                     :email, :password, :password_confirmation,
                                     :current_password)
      end
    end
  end
end
