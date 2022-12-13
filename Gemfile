# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'activerecord-import', '~>1.4'
gem 'bcrypt', '~> 3.1.7'
gem 'blueprinter'
gem 'bootsnap', require: false
gem 'caxlsx', '~>3.2.0'
gem 'caxlsx_rails', '~>0.6.3'
gem 'draper', '~>4.0'
gem 'pagy', '~>5.10.1'
gem 'pundit'
gem 'rails-i18n', '~>7.0.5'
gem 'rubyXL', '~>3.4'
gem 'rubyzip', '~> 2.3.2'
gem 'valid_email2', '~>4.0'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'faker', '~>2'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'bullet'
  gem 'letter_opener'
  gem 'rubocop', '~> 1.36', require: false
  gem 'rubocop-performance', '~> 1.15', require: false
  gem 'rubocop-rails', '~> 2.16', require: false
  gem 'solargraph'
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
