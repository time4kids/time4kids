# frozen_string_literal: true

module Auth
  class SessionsController < ::Devise::SessionsController
    include ApiResponder

    before_action :fix_params, only: :create

    def respond_with(resource, opts = {})
      respond_with_auth(resource, opts.merge(api_template: resource.role_specific_template(:self)))
    end

    def fix_params
      request.params[:user] = {
        email: request.params.delete(:email),
        password: request.params.delete(:password)
      }
    end

    def respond_to_on_destroy
      respond_with_success
    end
  end
end
