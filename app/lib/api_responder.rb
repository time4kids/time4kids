# frozen_string_literal: true

module ApiResponder
  class Responder < ActsAsApi::Responder
    def api_behavior
      if patch?
        display resource
      else
        super
      end
    end
  end

  include ActsAsApi::Rendering
  include ApiResponseFormatter

  def self.included(base)
    base.respond_to :json
    base.responder = ApiResponder::Responder
  end

  private

  def respond_with(resource, opts = {})
    if resource.is_a?(ActiveRecord::Base) && !resource.errors.empty?
      msg = resource.errors.messages.first.flatten.map(&:to_s).join(' ').humanize
      respond_with_error msg: msg, status: 422 and return
    else
      set_headers
      opts[:api_template] ||= :v1_default
      super(resource, opts)
    end
  end

  alias_method :original_respond_with, :respond_with

  def respond_with_auth(resource, opts = {})
    original_respond_with(resource, opts.merge(meta: auth_meta))
  end

  def respond_with_success(data = {})
    set_headers

    render json: success_response_body.merge(data)
  end

  def respond_with_error(msg: nil, status: 500)
    set_headers

    render json: error_response_body(msg, status.to_i), status: status.to_s
  end

  def auth_meta
    { token: "Bearer #{request.env['warden-jwt_auth.token']}" }
  end
end
