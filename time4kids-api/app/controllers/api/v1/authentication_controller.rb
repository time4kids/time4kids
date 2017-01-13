module API
  module V1
    class AuthenticationController < Knock::AuthTokenController

      private

        def entity_name
          'User'
        end
    end
  end
end
