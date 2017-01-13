module API
  module V1
    class BaseController < ::API::V1::ApiController
      before_action :log_additional_information
      before_action :validate_authentication
      before_action :log_jwt
      before_action :validate_accept_header_format
      before_action :validate_media_type, unless: -> { request.get? }

      private

      #
      # before filters
      #

      # Log HTTP headers (except for Authorization), Request-Id and token payload
      def log_additional_information
        request_headers = request.headers.env.select { |k| k =~ /\AHTTP|CONTENT/ }
        if request_headers.has_key?('HTTP_AUTHORIZATION')
          request_headers['HTTP_AUTHORIZATION'] = '[FILTERED]'
        end
        Rails.logger.info "Headers: #{request_headers.inspect}"
        Rails.logger.info "Request-Id: #{request.uuid}"
      end

      def log_jwt
        token.fmap { |t|
          Rails.logger.info "Token (valid): #{t.to_h.inspect}"
        }.or {
          Rails.logger.info "Token (invalid): #{token_content.inspect}"
        }
      end

      # Check if Authorization header and JWT token are correct
      def validate_authentication
        header_result = API::AuthorizationHeaderSchema.call(content: authorization_content)
        if header_result.failure?
          Rails.logger.error "Authorization header error: #{header_result.output.inspect}"
          raise API::Exception.new('auth.invalid_token', code: 401)
        end

        token_result = API::JWTSchema.call(token: token_content.value)
        if token_result.failure?
          Rails.logger.error "JWT error: #{token_result.output.inspect}"
          raise API::Exception.new('auth.invalid_token', code: 401)
        end
      end

      # Check if Accept header is properly formatted
      def validate_accept_header_format
        media_types
      rescue HTTP::Accept::ParseError
        msg = 'Accept header malformed'

        render json: msg, status: :bad_request
      end


      # Check if valid Content-Type was sent
      def validate_media_type
        if request.headers['Content-Type'] != 'application/vnd.time4kids+json'
          msg = "Content-Type header set to 'application/vnd.time4kids+json' required"
          render_json_api Api::Error.new(message: msg), status: :unsupported_media_type
        end
      end

      #
      # helpers
      #

      def authorization_content
        request.headers['Authorization']
      end

      def media_types
        HTTP::Accept::MediaTypes.parse(request.headers.fetch('Accept', ''))
      end

      def token_content
        Maybe(authorization_content) >-> authorization {
          _, content = authorization.split(' ', 2)

          Maybe(content)
        }
      end

      def token
        token_content >-> content {
          adapter = API::JWTAdapter.new

          Try { adapter.decode(content) }.to_maybe
        }
      end

      def set_headers(content_type: 'application/vnd.time4kids+json')
        # allow embedding in iframes
        headers.delete 'X-Frame-Options'

        # superfluous headers
        headers.delete 'X-Content-Type-Options'
        headers.delete 'X-UA-Compatible'
        headers.delete 'X-XSS-Protection'

        # keep #render with :content_type from appending character encoding media type param
        headers['Content-Type'] = content_type
      end
    end
  end
end
