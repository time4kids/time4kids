ActsAsApi::ApiTemplate.class_eval do

  private

  def process_value(model, value, options)
    case value
    when Symbol
      _value = model.send(value)
      if model.class.columns_hash[value.to_s]&.type == :datetime && _value.present?
        _value = _value.utc.iso8601
      end
      _value
    when Proc
      call_proc(value, model, options)
    when String
      value.split('.').inject(model) { |result, method| result.send(method) }
    when Hash
      to_response_hash(model, value)
    end
  end
end
