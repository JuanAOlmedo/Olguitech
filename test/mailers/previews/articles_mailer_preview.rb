# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/articles_mailer
class ArticlesMailerPreview < ActionMailer::Preview
    # Preview this email at http://localhost:3000/rails/mailers/articles_mailer/article
    def article
        I18n.locale = :es

        user = User.last
        article = Solution.last

        ArticlesMailer.article(user, article)
    end
end
