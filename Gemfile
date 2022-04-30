source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'pg'
gem 'rubocop', '~> 1.28', require: false
gem 'paranoia', '~> 2.6'
gem 'braintree', '~> 4.7'
gem 'friendly_id', '~> 5.4'
gem 'image_processing', '~> 1.2'
gem 'rails', '>= 6.1.5.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.2'
gem 'pundit', '~> 2.2'
gem 'stimulus-rails', '~> 1.0', '>= 1.0.4'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 3.36'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.20'
  gem 'rspec-rails', '~> 5.1'
end

group :development do
  gem 'foreman', '~> 0.87.2'
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
