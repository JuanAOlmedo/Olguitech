# frozen_string_literal: true

# Para enviar mails confirmando la suscripción a la newsletter
class SubscriptionMailer < ApplicationMailer
    def subscribe(user)
        user.regenerate_confirmation_token if user.confirmation_token.nil?
        user.regenerate_edit_token if user.edit_token.nil?
        user.regenerate_newsletter_token if user.newsletter_token.nil?

        @email = user.email
        @confirmed = user.confirmed?
        @confirmation = confirm_users_url confirmation_token: user.confirmation_token
        @edit = edit_user_url user, edit_token: user.edit_token
        @unsubscribe = unsubscribe_users_url newsletter_token: user.newsletter_token

        I18n.with_locale(user.locale) do
            mail to: @email, subject: t('mail.subscription.subject')
        end
    end
end
