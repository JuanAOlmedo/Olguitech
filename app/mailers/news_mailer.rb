class NewsMailer < ApplicationMailer
    default from: ENV['EMAIL_USERNAME']
    layout 'mailer'

    def newsletter(user, title, content, subject)
        @user = user
        
        if @user.newsletter_token == nil
            @user.regenerate_newsletter_token
        end

        @token = @user.newsletter_token
        @title = title
        @content = content
        @subject = subject
        
        mail(to: @user.email, subject: @subject)
    end
end