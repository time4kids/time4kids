module API
  module V1
    class ApiController < ActionController::API
      include API::ErrorsHandler
      include Knock::Authenticable
      undef_method :current_user

      respond_to :json

      before_action :validate_media_type

      private

      # Check if valid Content-Type was sent
      def validate_media_type
        ['application/vnd.time4kids+json', 'application/json'].map do |type|
          unless request.headers['Content-Type'] .include? type
            raise API::Exception.new('request.unsupported_media_type', { valid_media_type: type,
                                                                                                                code: 415 })
          end
        end
      end
    end
  end
end
