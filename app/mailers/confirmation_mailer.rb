# frozen_string_literal: true

class ConfirmationMailer < ApplicationMailer
    def confirmation_instructions(user)
        @user = user
        @email = user.email
        @token = user.confirmation_token

        I18n.with_locale(@user.locale) do
            mail(to: user.email, subject: t('mail.confirmation.subject'))
        end
    end
end
