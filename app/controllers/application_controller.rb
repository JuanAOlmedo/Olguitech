# frozen_string_literal: true

class ApplicationController < ActionController::Base
    around_action :switch_locale

    # Change language to the one provided in the parameters and fallback to
    # spanish in case it is not valid
    def switch_locale(&action)
        locale = I18n.locale_available?(params[:locale]) ? params[:locale] : I18n.default_locale

        I18n.with_locale locale, &action
    end

    def default_url_options
        { locale: I18n.locale }
    end
end
