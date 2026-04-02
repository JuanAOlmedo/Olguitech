# frozen_string_literal: true

RailsCloudflareTurnstile.configure do |config|
    config.site_key = Rails.application.credentials.CLOUDFLARE_TURNSTILE_SITE_KEY
    config.secret_key = Rails.application.credentials.CLOUDFLARE_TURNSTILE_SECRET_KEY
    config.fail_open = true
    config.theme = :light
end
