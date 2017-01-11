module API
  class ErrorHandler
    included do
      rescue_from Exception do |error|
        if error.is_a? API::Exception
          render json: error.as_json, status: error.status.to_sym
        end
      end
    end
  end
end
