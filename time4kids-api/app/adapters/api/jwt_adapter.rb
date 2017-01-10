module API
  # This adapter wraps up currently used JWT gem
  #
  # Generate your own token: http://jwt.io/#debugger. Only for development/testing purposes!
  # RFC 7519: https://tools.ietf.org/html/rfc7519
  # IANA JWT claims: https://www.iana.org/assignments/jwt/jwt.xhtml
  class JWTAdapter
    class Error < ::StandardError; end
    # Raised when there's a problem with a token. Makes the controller return 401.
    class InvalidTokenError < Error; end

    ALGORITHM = 'HS256'
    private_constant :ALGORITHM

    # Encodes payload into JWT token
    #
    # @param user_id [String,Fixnum] user ID
    # @returns [String] JWT token
    def encode(user_id:)
      raise ArgumentError if user_id.blank?

      payload = {
        exp: 1.month.from_now.utc.to_i,
        iat: Time.now.utc.to_i,
        sub: user_id.to_s,
      }
      JWT.encode payload, Time4kids::Env.fetch('JWT_SECRET'), ALGORITHM
    end

    # Decodes JWT token, verifies it and extracts its payload
    #
    # @param token [String]
    # @returns [Token] token's payload
    def decode(token)
      verify_signature = true
      options = {algorithm: ALGORITHM, verify_expiration: true}

      begin
        payload, _ = JWT.decode token, Time4kids::Env.fetch('JWT_SECRET'), verify_signature, options
      rescue JWT::ExpiredSignature
        Rails.logger.info 'JWTAdapter: Expired JWT'
        raise InvalidTokenError
      rescue JWT::IncorrectAlgorithm => e
        Rails.logger.error 'JWTAdapter: Incorrect algorithm'
        raise InvalidTokenError
      rescue JWT::VerificationError => e
        Rails.logger.error 'JWTAdapter: Invalid JWT signature. Verification failed'
        raise InvalidTokenError
      rescue JWT::DecodeError => e
        Rails.logger.error 'JWTAdapter: Error decoding JWT'
        raise InvalidTokenError
      end

      payload.fetch('sub')
    end

    private

    # Only take header and payload from the token. Logging the last part (signature) is a potential
    # security risk
    def strip_token(token)
      token.present? ? token.split('.', 2).join('.') : nil
    end
  end
end
