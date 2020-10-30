source 'https://rubygems.org'

# For Health checks
gem 'health_bit'

group :application do
  # Only load required mime types to save on RAM
  gem "mime-types", "~> 2.6.1", require: "mime/types/columnar"
  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  # gem 'rails', '4.2.0.rc1'
  gem 'rails', '4.2.11.3'
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.0'
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 1.0.0', group: :doc
  
  # gem 'json', '2.0.1'

  gem 'draper'
  gem 'fastimage'
  gem "rb-readline"
  gem 'ruby-vips'

  # Use ActiveModel has_secure_password
  # gem 'bcrypt', '~> 3.1.7'

  # Use Unicorn as the app server
  # gem 'unicorn'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :application, :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem "spring-commands-rspec"

  gem 'rspec-rails', '~> 3.0'
  gem 'rspec-collection_matchers'

  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rails'
  gem 'guard-coffeescript'
  gem 'guard-bundler'
  gem "growl"

  gem 'coveralls', require: false

end

# For Sentry
gem 'sentry-raven'

gem 'newrelic_rpm'

group :deployment do
  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
end
