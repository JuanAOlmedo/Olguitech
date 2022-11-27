# frozen_string_literal: true

class ContactMailer < ApplicationMailer
    def contacto(user, contact)
        @user = user
        @preference = Article.find(contact.preference).localized_title
        @preference2 = Project.find(contact.preference2).localized_title
        @message = contact.message

        I18n.with_locale(@user.locale) do
            mail(to: @user.email, subject: 'Olguitech s.a.s.')
        end
    end

    def admin_contacto(user, contact)
        @user = user
        @preference = Article.find(contact.preference).localized_title
        @preference2 = Project.find(contact.preference2).localized_title
        @message = contact.message
        @locale = I18n.locale == :es ? 'Español' : 'Inglés'

        mail(
            to: ENV['EMAIL_USERNAME'],
            subject: 'Una nueva persona se ha contactado'
        )
    end
end
