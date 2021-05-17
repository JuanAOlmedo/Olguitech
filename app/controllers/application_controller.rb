class ApplicationController < ActionController::Base
    around_action :switch_locale

    def switch_locale(&action)
        if user_signed_in? && !params[:locale] && current_user.try(:locale)
            redirect_to url_for( locale: current_user.locale )
        else
            locale = params[:locale] || I18n.default_locale

            if locale == "es" || locale == "en"
                I18n.with_locale(locale, &action)
            else 
                I18n.with_locale("es", &action)
            end

            if user_signed_in?
                current_user.locale = locale
                current_user.save!
            end
        end
    end

    def default_url_options
        locale = current_user.try(:locale) || I18n.locale
        { locale: locale }
    end
end
