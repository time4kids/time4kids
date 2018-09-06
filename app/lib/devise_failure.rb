class DeviseFailure < Devise::FailureApp
  include ApiResponseFormatter

  def respond
    if request.format == :json
      set_headers
      
      self.status = 401
      self.response_body = error_response_body(i18n_message, self.status).to_json
    else
      super
    end
  end
end
