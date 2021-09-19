require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
    setup { @user = users(:one) }

    test 'contacto' do
        mail = ContactMailer.contacto(@user, Article.first.get_title, Proyecto.first.get_title, "HI")

        assert_equal 'Olguitech s.a.s.', mail.subject
        assert_equal [@user.email], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match "HI", mail.body.encoded
        assert_match Proyecto.first.get_title, mail.body.encoded
        assert_match Article.first.get_title, mail.body.encoded
    end

    test 'admin_contacto' do
        mail = ContactMailer.admin_contacto(@user, Article.first.get_title, Proyecto.first.get_title, "HI")

        assert_equal 'Una nueva persona se ha contactado', mail.subject
        assert_equal [ENV['EMAIL_USERNAME']], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match "HI", mail.body.encoded
        assert_match Proyecto.first.get_title, mail.body.encoded
        assert_match Article.first.get_title, mail.body.encoded
    end
end
