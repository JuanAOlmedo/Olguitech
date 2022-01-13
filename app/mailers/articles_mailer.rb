class ArticlesMailer < ApplicationMailer
    def article(user, article)
        @user = user

        @user.regenerate_newsletter_token if @user.newsletter_token == nil

        @token = @user.newsletter_token
        @article = article

        I18n.with_locale(@user.locale) do
            mail(to: @user.email, 
                subject: "#{@article.model_name.singular == "article" ? t("mail.articles.subject.new1") : t("mail.articles.subject.new2")} #{@article.model_name.human} #{t("mail.articles.subject.from")} Olguitech!")
        end
    end
end
