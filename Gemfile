# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'activeadmin'
# gem 'active_admin_sidebar'
# gem 'arctic_admin'
# gem 'active_admin-subnav'
gem 'bcrypt'
# gem 'bootstrap-sass'
gem 'cancancan'
gem 'devise'
gem 'draper'
gem 'erb_lint'
# gem 'ffaker'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 6.1.4', '>= 6.1.4.3'
#gem 'rails', '~> 7.0.0'
gem 'sass-rails', '>= 6'
# gem 'jquery-turbolinks'
gem 'bootstrap' # , '~> 5.0.2'
gem 'breadcrumbs_on_rails'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'font-awesome-rails'
gem 'font-awesome-sass', '~> 5.15.1'
gem 'grape'
gem 'grape-entity'
gem 'grape-kaminari'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-representable'
gem 'image_processing'
gem 'jquery-rails'
gem 'letter_opener'
gem 'rails-i18n', '~> 6.0'
gem 'resque'
gem 'resque-scheduler'
gem 'rmagick'
gem 'slim-rails'
gem 'webpacker' # '~> 5.0'
gem 'whenever', require: false
# Reduces boot times through caching; required in config/boot.rb
gem 'aasm'
gem 'aasm-diagram'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'caxlsx'
gem 'dry-initializer'
gem 'dry-struct'
gem 'dry-validation'
gem 'httparty'
gem 'net-smtp', require: false
gem 'rack-mini-profiler', '~> 2.0'
gem 'redis-rails'
gem 'roo'
gem 'sprockets-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  # gem 'rspec-rails', '~> 6.0.0'
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main'
  end
  gem 'pry-byebug'
  gem 'rexml'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'pundit-matchers', '~> 1.7.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md

  gem 'html2slim'
  gem 'listen', '~> 3.3'
  gem 'lorem_ipsum_amet', '~> 0.6.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
