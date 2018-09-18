# frozen_string_literal: true

module V1
  class ApiController < ::ApplicationController
    include ApiResponder

    before_action :authenticate_user!

    rescue_from ActionController::ParameterMissing do |ex|
      respond_with_error(msg: ex.message, status: 400)
    end

    rescue_from CanCan::AccessDenied do |ex|
      respond_with_error(msg: ex.message, status: 403)
    end
  end
end
