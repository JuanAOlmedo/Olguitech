# frozen_string_literal: true

module Admins
    class SessionsController < Devise::SessionsController
        before_action :validate_turnstile_and_redirect, only: [:create]

        private

        def validate_turnstile_and_redirect
            validate_cloudflare_turnstile unless Rails.env.test?
        rescue RailsCloudflareTurnstile::Forbidden
            render 'sessions/new', status: :see_other, alert: 'No pudimos verificar que seas humano. Intenta nuevamente.'
        end
    end
end
