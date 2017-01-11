module API
  class Exception < ::Exception
    attr_accessor :details
    attr_accessor :key
    attr_accessor :code

    attr_accessor :status
    attr_accessor :title
    attr_accessor :detail

    def initialize(key, details = {})
      @details = details
      @key = key
      @code = details.fetch(:code, 500)

      @status = I18n.t "exceptions.#{key}.status"
      @title  = I18n.t "exceptions.#{key}.title", details
      @detail = I18n.t "exceptions.#{key}.detail", details

      @message = @detail
    end

    def as_json
      {
        title: title,
        detail: detail,
        status: status,
        code: code
      }
    end
  end
end
