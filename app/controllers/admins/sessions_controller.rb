# frozen_string_literal: true

module Admins
    class SessionsController < Devise::SessionsController
        include Captcha

        before_action :validate_turnstile_and_redirect, only: [:create]

        private

        def validate_turnstile_and_redirect
            check_recaptcha!
        rescue CaptchaError
            redirect_to new_admin_session_path, status: :see_other, alert: 'No pudimos verificar que seas humano. Intenta nuevamente.'
        end
    end
end
