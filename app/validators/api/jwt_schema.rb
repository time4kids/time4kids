module API
  JWTSchema = ::Dry::Validation.Schema do
    key(:token).required(:jwt?)

    configure do
      config.messages = :i18n

      option :jwt_adapter, API::JWTAdapter

      def jwt?(value)
        jwt_adapter.new.decode(value)
      rescue API::JWTAdapter::InvalidTokenError
        false
      else
        true
      end
    end
  end
end
