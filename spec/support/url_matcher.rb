# Passes if result is a valid url, returns error "expected result to be url" if not.

# Matcher to see if a string is a URL or not.
# RSpec::Matchers.define :be_url do |expected|
#   # The match method, returns true if valie, false if not.
#   match do |actual|
#     # Use the URI library to parse the string, returning false if this fails.
#     !!(actual =~ /\A#{URI::regexp(['http', 'https'])}\z/)
#   end
# end
