class ApplicationController < ActionController::Base
    around_action :switch_locale

    def switch_locale(&action)
        locale = params[:locale] || I18n.default_locale

        if locale == 'es' || locale == 'en'
            I18n.with_locale(locale, &action)
        else
            I18n.with_locale('es', &action)
        end
    end

    def default_url_options
        { locale: I18n.locale }
    end
end
