class ArticlesMailer < ApplicationMailer
    default from: ENV['EMAIL_USERNAME']
    layout 'mailer'

    def article(user, article)
        @user = user
        @article = article
        
        mail(to: @user.email, subject: 'Olguitech s.a.s., Nuevo Artículo')
    end
end