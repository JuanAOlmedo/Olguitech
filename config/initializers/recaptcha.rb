# frozen_string_literal: true

Recaptcha.configure do |config|
    config.site_key = Rails.application.credentials.CAPTCHA_SITE_KEY
    config.secret_key = Rails.application.credentials.CAPTCHA_SECRET_KEY
end
