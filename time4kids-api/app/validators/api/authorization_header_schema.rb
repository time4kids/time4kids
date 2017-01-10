module API
  AuthorizationHeaderSchema = ::Dry::Validation.Schema do
    key(:content).required(format?: /\ABearer ([\-\w]+\.){2}[\-\w]+\z/)
  end
end
