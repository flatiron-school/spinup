source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails', '4.1.0.rc2'
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'spring',           group: :development
gem 'figaro', git: 'git@github.com:laserlemon/figaro.git'
gem 'digitalocean'
gem 'omniauth'
gem 'omniauth-github'
gem 'sidekiq'
gem 'typhoeus'
gem 'faraday'

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'better_errors'
  gem 'sprockets_better_errors'
  gem 'binding_of_caller'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'database_cleaner'
  gem 'sqlite3'
  gem 'pry'
end

group :production do
  gem 'pg'
  gem 'google-analytics-rails'
  gem 'rails_12factor'
end

gem 'bootstrap-sass', '~> 3.1.1'
gem 'airbrake'