# frozen_string_literal: true

module Auth
  class RegistrationsController < ::Devise::RegistrationsController
    include ApiResponder

    def respond_with(resource, opts = {})
      respond_with_auth(resource, opts.merge(api_template: resource.role_specific_template(:self)))
    end

    def sign_up_params
      res = fix_nested_attributes(
        params.require(:user).permit(
          :email, :password, :first_name, :last_name, :avatar, :role,
          profile: [
            :name, :phone, :web_site, :description,
            address: %i(country region city street number postal_code)
          ]
        ), :profile, :address
      )

      res
    end

    def account_update_params
      res = fix_nested_attributes(
        params.require(:user).permit(
          :email, :password, :password_confirmation, :current_password,
          :first_name, :last_name, :avatar,
          profile: [
            :name, :phone, :web_site, :description,
            address: %i(country region city street number postal_code)
          ]
        ), :profile, :address
      )

      res
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end
  end
end
