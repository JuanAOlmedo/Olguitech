class CaptchaError < StandardError; end

# Provee un método para verificar captchas, lanzando la excepción CaptchaError si la verificación falla.
module Captcha
    extend ActiveSupport::Concern

    private

    def check_recaptcha!(model = nil)
        #return unless Rails.env.production?

        return if verify_recaptcha minimum_score: 0.5

        model&.errors&.add(:base, I18n.t('contact.captcha_failed'))
        raise CaptchaError
    end
end
