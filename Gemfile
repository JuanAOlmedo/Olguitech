source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '8.0.2'

# Use pg as the database for Active Record in production
gem 'pg'

# Use Puma as the app server
gem 'puma'

# Use SCSS for stylesheets
gem 'sassc-rails'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.13'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'rexml', '~> 3.4', '>= 3.2.4'

# Use devise for authentication
gem 'bcrypt_pbkdf'
gem 'devise', '~> 4.9'
gem 'ed25519'

# Captcha
gem 'invisible_captcha'

# Use simple_form for devise forms
gem 'simple_form', '5.3.0'

# Use Active Storage variant
gem 'image_processing', '~> 1.14'
gem 'mini_magick'

# Use terser for JavaScript compression
gem 'terser'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use friendly_id for url ids
gem 'friendly_id', '~> 5.5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'

group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platforms: %i[mri mingw x64_mingw]
    gem 'sqlite3'
    gem 'ruby-lsp'
    gem 'solargraph'
end

group :development do
    # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
    gem 'web-console', '>= 3.3.0'
end

group :test do
    # Adds support for Capybara system testing and selenium driver
    gem 'capybara'
    gem 'selenium-webdriver'
end

# Use capistrano to deploy to production
gem 'capistrano', '~> 3.19'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rails', '~> 1.7'
gem 'capistrano-rbenv', '~> 2.2'
