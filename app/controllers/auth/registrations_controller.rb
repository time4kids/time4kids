module Auth
  class RegistrationsController < ::Devise::RegistrationsController
    include ApiResponder

    def respond_with(resource, opts = {})
      respond_with_auth(resource, opts.merge(api_template: resource.role_specific_template(:self)))
    end

    def sign_up_params
      res = fix_nested_attributes(params.require(:user).permit(
        :full_name, :email, :password)
      res
    end
  end
end
