# frozen_string_literal: true

class ApplicationController < ActionController::Base
    around_action :switch_locale
    before_action :detect_webp_support

    # Change language to the one provided in the parameters and fallback to
    # spanish in case it is not valid
    def switch_locale(&action)
        locale = I18n.locale_available?(params[:locale]) ? params[:locale] : I18n.default_locale

        I18n.with_locale locale, &action
    end

    # Detect WebP support in the browser's headers to serve images accordingly
    def detect_webp_support
        @webp = request.env['HTTP_ACCEPT'].include? 'image/webp'
    end

    def default_url_options
        { locale: I18n.locale }
    end
end
