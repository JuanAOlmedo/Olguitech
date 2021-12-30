require 'test_helper'

class ArticlesMailerTest < ActionMailer::TestCase
    setup do
        I18n.locale = :es

        @user = users(:one)
        @article = articles(:one)
    end

    test 'article' do
        mail = ArticlesMailer.article(@user, @article)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Nuevo Artículo de Olguitech!', mail.subject
        assert_equal [@user.email], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match @article.title, mail.body.encoded
        assert_match "Desuscribirse", mail.body.encoded
    end
end
