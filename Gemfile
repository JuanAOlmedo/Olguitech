source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '7.0.1'

# Use pg as the database for Active Record in production
gem 'pg'

# Use Puma as the app server
gem "puma", ">= 5.5.1"

# Use SCSS for stylesheets
gem 'sassc-rails'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'rexml', '~> 3.2', '>= 3.2.4'

# Use devise for authentication
gem 'devise', '4.8.1'

# Use simple_form for devise forms
gem 'simple_form', '5.1.0'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'mini_magick'

# Use terser for JavaScript compression
gem 'terser'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use friendly_id for url ids
gem 'friendly_id', '~> 5.4.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platforms: %i[mri mingw x64_mingw]
    gem 'sqlite3'
end

group :development do
    # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
    gem 'web-console', '>= 3.3.0'
end

group :test do
    # Adds support for Capybara system testing and selenium driver
    gem 'capybara', '>= 2.15'
    gem 'selenium-webdriver'

    # Easy installation and use of web drivers to run system tests with browsers
    gem 'webdrivers'
end

# Use capistrano to deploy to production
gem 'capistrano', '~> 3.11'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
