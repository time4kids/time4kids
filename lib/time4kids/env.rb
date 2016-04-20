module Time4kids
  module Env
    def self.fetch(env_var)
      ENV[env_var] || fail("#{env_var} environment variable needs to be set")
    end
  end
end
