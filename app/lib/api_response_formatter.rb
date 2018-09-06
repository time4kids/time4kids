# frozen_string_literal: true

module ApiResponseFormatter

  private

  def success_response_body
    { success: true }
  end

  def error_response_body(msg, status)
    response = {
      message: msg ? msg.to_s : default_error_messages.fetch(status, '')
    }
    { error: response }
  end

  def default_error_messages
    {
      400 => 'Bad request',
      401 => 'Unauthorized',
      402 => 'Payment required',
      403 => 'Forbidden',
      404 => 'Page not found',
      422 => 'Unprocessable Entity',
      500 => 'Internal server error'
    }
  end

  def set_headers(content_type: 'application/json')
    # superfluous headers
    headers.delete 'X-Content-Type-Options'
    headers.delete 'X-UA-Compatible'
    headers.delete 'X-XSS-Protection'

    # keep #render with :content_type from appending character encoding media type param
    headers['Content-Type'] = content_type
  end
end
