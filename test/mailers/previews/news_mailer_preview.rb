# Preview all emails at http://localhost:3000/rails/mailers/news_mailer
class NewsMailerPreview < ActionMailer::Preview

    # Preview this email at http://localhost:3000/rails/mailers/news_mailer/newsletter
    def newsletter
        user = User.last
        newsletter = Newsletter.last

        NewsMailer.newsletter(user, newsletter)
    end
end
