# frozen_string_literal: true

class ContactMailer < ApplicationMailer
    def contacto(user, contact)
        @user = user
        @contact = contact

        I18n.with_locale(@user.locale) do
            mail(to: @user.email, subject: 'Olguitech s.a.s.')
        end
    end

    def admin_contacto(user, contact)
        @user = user
        @contact = contact

        mail to: ENV['EMAIL_USERNAME'], subject: 'Una nueva persona se ha contactado'
    end
end
