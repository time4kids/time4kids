source 'https://rubygems.org'
# keep it first to set environment variables before other gems load
gem 'dotenv-rails', groups: [:development, :test]
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.13', '< 0.5'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
group :assets do
  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '~> 4.1.0'
  # Use jquery as the JavaScript library
  gem 'jquery-rails'
  # Use SCSS for stylesheets
  gem 'sass-rails', '>= 3.2'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'

  gem 'bootstrap-sass', '~> 3.3.6'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'simple_form'
# slim-rails provides Slim generators for Rails 3 and 4
gem 'slim-rails'

gem 'devise'
gem 'i18n'
# Use Unicorn as the app server
gem 'unicorn'

# Easy file attachment management for ActiveRecord
gem 'paperclip'

gem 'responders'

# gem 'active_model_serializers'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'better_errors'
  # Preview mail in the browser instead of sending.
  gem 'letter_opener'
  gem 'rubocop'
  gem 'rails_layout'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'forgery'
  gem 'capybara'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end
