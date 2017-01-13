module API
  module V1
    class ApiController < ActionController::API
      skip_before_action :verify_authenticity_token

      include API::ErrorsHandler

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
