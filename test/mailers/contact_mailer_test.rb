# frozen_string_literal: true

require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
    setup { @user = users(:one) }

    test 'contacto' do
        mail = ContactMailer.contacto(@user, Article.first.localized_title,
                                      Proyecto.first.localized_title, 'HI')

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Olguitech s.a.s.', mail.subject
        assert_equal [@user.email], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match 'HI', mail.body.encoded
        assert_match Proyecto.first.localized_title, mail.body.encoded
        assert_match Article.first.localized_title, mail.body.encoded
    end

    test 'admin_contacto' do
        mail = ContactMailer.admin_contacto(@user, Article.first.localized_title,
                                            Proyecto.first.localized_title, 'HI')

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Una nueva persona se ha contactado', mail.subject
        assert_equal [ENV['EMAIL_USERNAME']], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match 'HI', mail.body.encoded
        assert_match Proyecto.first.localized_title, mail.body.encoded
        assert_match Article.first.localized_title, mail.body.encoded
    end
end
