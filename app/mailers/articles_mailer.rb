# frozen_string_literal: true

# Mailer for creating solutions
class ArticlesMailer < ApplicationMailer
    def article(user, article)
        @user = user
        @user.regenerate_newsletter_token if @user.newsletter_token.nil?

        @token = @user.newsletter_token
        @article = article

        I18n.with_locale(@user.locale) do
            model_name = @article.model_name.singular
            human = @article.model_name.human

            subject = if model_name == 'solution'
                          t('mail.articles.subject.new1')
                      else
                          t('mail.articles.subject.new2')
                      end + " #{human} #{t('mail.articles.subject.from')} Olguitech!"
            mail(to: @user.email, subject:)
        end
    end
end
