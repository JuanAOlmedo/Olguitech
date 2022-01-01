class ArticlesMailer < ApplicationMailer
    default from: ENV['EMAIL_USERNAME']
    layout 'mailer'

    def article(user, article)
        @user = user

        @user.regenerate_newsletter_token if @user.newsletter_token == nil

        @token = @user.newsletter_token
        @article = article

        mail(to: @user.email, subject: "#{@article.model_name.singular == "article" ? "Nueva" : "Nuevo"} #{@article.model_name.human} de Olguitech!")
    end
end
