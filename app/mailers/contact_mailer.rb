# frozen_string_literal: true

class ContactMailer < ApplicationMailer
    def contacto(user, interests, message)
        @user = user
        @interests = interests
        @message = message

        I18n.with_locale(@user.locale) do
            mail(to: @user.email, subject: 'Olguitech s.a.s.')
        end
    end

    def admin_contacto(user, interests, message)
        @user = user
        @interests = interests
        @message = message
        @locale = I18n.locale == :es ? 'Español' : 'Inglés'

        mail(
            to: ENV['EMAIL_USERNAME'],
            subject: 'Una nueva persona se ha contactado'
        )
    end
end
