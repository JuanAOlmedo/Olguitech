# frozen_string_literal: true

Recaptcha.configure do |config|
    config.site_key = Rails.application.credentials.CAPTCHA_SITE_KEY
    config.secret_key = Rails.application.credentials.CAPTCHA_SECRET_KEY
    config.verify_url = 'https://hcaptcha.com/siteverify'
    config.api_server_url = 'https://hcaptcha.com/1/api.js'
    config.response_limit = 100_000
    config.response_minimum = 100
end
