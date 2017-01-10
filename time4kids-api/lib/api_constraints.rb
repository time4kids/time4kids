class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || valid_accept_header?
  end

  def valid_accept_header?
    req.headers['Accept'].include?("application/vnd.time4kids.v#{@version}+json")
  end
end
