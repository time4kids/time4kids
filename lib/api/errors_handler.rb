module API::ErrorsHandler
  def self.included(base)
    base.class_eval do
      rescue_from API::Exception do |error|
        render json: error.as_json, status: error.status.to_sym
      end
    end
  end
end
