class ArticlesMailer < ApplicationMailer
    default from: ENV['EMAIL_USERNAME']
    layout 'mailer'

    def article(user, article)
        @user = user

        if @user.newsletter_token == nil
            @user.regenerate_newsletter_token
        end

        @token = @user.newsletter_token
        @article = article
        
        mail(to: @user.email, subject: 'Olguitech s.a.s., Nuevo Artículo')
    end
end