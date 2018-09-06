class ApplicationController < ActionController::API
  private

  def fix_nested_attributes(params, *keys)
    paths = keys.map{ |k| k.to_s.split('.') }.sort_by{ |a| -a.length }

    paths.each do |path|
      if params.dig(*path)
        container_path = path[0...-1]
        container = container_path.present? ? params.dig(*container_path) : params
        container["#{path.last}_attributes"] = container.delete(path.last)
      end
    end

    params
  end
end
