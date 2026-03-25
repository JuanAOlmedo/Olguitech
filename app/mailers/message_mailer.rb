# frozen_string_literal: true

class MessageMailer < ApplicationMailer
    def user_mail(user, message)
        @user = user
        @message = message

        I18n.with_locale(@user.locale) do
            mail to: @user.email, subject: 'Olguitech s.a.s.'
        end
    end

    def admin_mail(user, message)
        @user = user
        @message = message

        mail to: ENV.fetch('EMAIL_USERNAME', 'olguitech@olguitech.com'), subject: 'Una nueva persona se ha contactado'
    end
end
