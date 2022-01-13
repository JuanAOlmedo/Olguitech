class NewsMailer < ApplicationMailer
    default from: ENV['EMAIL_USERNAME']
    layout 'mailer'

    def newsletter(user, newsletter)
        @user = user

        @user.regenerate_edit_token if @user.edit_token == nil
        @user.regenerate_newsletter_token if @user.newsletter_token == nil

        @token = @user.newsletter_token
        @link = newsletter_url(newsletter, locale: I18n.locale)
        @title = newsletter.title
        @content = newsletter.content
        @subject = newsletter.subject

        mail(to: @user.email, subject: @subject)
    end
end
