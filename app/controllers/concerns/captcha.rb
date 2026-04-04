# Provee un método para verificar captchas, lanzando la excepción Captcha::Invalid si la verificación falla.
module Captcha
    class Invalid < StandardError; end

    extend ActiveSupport::Concern

    private

    def check_recaptcha!(model = nil)
        return if verify_recaptcha model: model, secret_key: Rails.application.credentials.CAPTCHA_SECRET_KEY

        raise Captcha::Invalid
    end
end
