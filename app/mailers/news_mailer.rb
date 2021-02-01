class NewsMailer < ApplicationMailer
    default from: ENV['EMAIL_USERNAME']
    layout 'mailer'

    def newsletter(user, title, content, subject)
        @user = user
        @title = title
        @content = content
        @subject = subject
        
        mail(to: @user.email, subject: @subject)
    end
end