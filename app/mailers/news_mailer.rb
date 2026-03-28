# frozen_string_literal: true

# Mailer for newsltters
class NewsMailer < ApplicationMailer
    def newsletter(user, newsletter)
        @user = user

        @user.regenerate_edit_token if @user.edit_token.nil?
        @user.regenerate_newsletter_token if @user.newsletter_token.nil?

        @token = @user.newsletter_token
        @link = newsletter_url(newsletter, locale: I18n.locale)
        @title = newsletter.title
        @content = newsletter.content
        @subject = newsletter.subject

        headers['List-Unsubscribe'] = '<https://olguitech.com/unsubscribe?token=#{user.newsletter_token}>'
        headers['List-Unsubscribe-Post'] = "List-Unsubscribe=One-Click"

        mail(to: @user.email, subject: @subject)
    end
end
