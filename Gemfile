source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'

# Use Puma as the app server
gem 'puma', '~> 3.10.0'
gem 'rack-timeout'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Use HAML for our view rendering
gem 'haml'

# Use Parliament-Ruby for web requests
gem 'parliament-ruby', '~> 0.8'

# Parliament Grom Decorators decorates Grom nodes
gem 'parliament-grom-decorators', '~> 0.10'

# Converts GeoSparql to GeoJSON
gem 'geosparql_to_geojson', '~> 0.1'

# Parliament routing
gem 'parliament-routes', '~> 0.3'

# Parliament-Utils gem for generic set up and configuration
gem 'parliament-utils', '~> 0.3', require: false

# Parliament NTriple processes N-triple data
gem 'parliament-ntriple', '~> 0.2', require: false

# Use bandiera-client for feature flagging
gem 'bandiera-client'

# Use Pugin for front-end components and templates
gem 'pugin', '~> 1.3', require: false

# Use dotenv to override environment variables
gem 'dotenv'

# Use Airbrake for error monitoring
gem 'airbrake'

# Gem to remove trailing slashes
gem 'rack-rewrite'

# Include time zone information
gem 'tzinfo-data'

gem 'vcard', '~> 0.2'

if %w(2.2.7 2.3.4 2.4.1).include? RUBY_VERSION
  gem "stopgap_13632", "~> 1.0", :platforms => ["mri", "mingw", "x64_mingw"]
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Use parallel_tests to run specs across all CPU cores locally
  gem 'parallel_tests'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rake'
  gem 'capybara'
  gem 'rspec-rails'
  gem 'simplecov', '~> 0.14', require: false
  gem 'vcr'
  gem 'webmock'
  gem 'rubocop'
  gem 'rails-controller-testing'
  gem 'timecop'
end
