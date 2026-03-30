# frozen_string_literal: true

class MessageMailer < ApplicationMailer
    def user_mail(user, message)
        @user.regenerate_edit_token if @user.edit_token.nil?
        @user.regenerate_confirmation_token if @user.confirmation_token.nil?

        @name = user.name.empty? ? user.email : user.name
        @message = message.content
        @confirmed = user.confirmed?
        @edit_link = edit_user_url user, edit_token: user.edit_token
        @confirmation_link = confirm_users_url confirmation_token: user.confirmation_token

        I18n.with_locale(user.locale) do
            mail to: user.email, subject: I18n.t('mail.contact.subject')
        end
    end

    def admin_mail(user, message)
        @user = user
        @message = message

        mail to: ENV.fetch('EMAIL_USERNAME', 'olguitech@olguitech.com'), subject: 'Una nueva persona se contactó'
    end
end
