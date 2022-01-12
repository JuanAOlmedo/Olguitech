class ConfirmationMailer < ApplicationMailer
    default from: ENV['EMAIL_USERNAME']
    layout 'mailer'

    def confirmation_instructions(user)
        @user = user
        @email = user.email
        @token = user.confirmation_token

        I18n.with_locale(@user.locale) do
            mail(to: user.email, subject: t("mail.confirmation.subject"))
        end
    end
end
