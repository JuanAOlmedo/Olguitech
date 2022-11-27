# frozen_string_literal: true

require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
    setup do
        @user = users(:one)
        @contacto = @user.contactos.create(preference: 1, preference2: 1, message: 'HI')
    end

    test 'contacto' do
        mail = ContactMailer.contacto(@user, @contacto)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Olguitech s.a.s.', mail.subject
        assert_equal [@user.email], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match 'HI', mail.body.encoded
        assert_match Project.first.localized_title, mail.body.encoded
        assert_match Article.first.localized_title, mail.body.encoded
    end

    test 'admin_contacto' do
        mail = ContactMailer.admin_contacto(@user, @contacto)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Una nueva persona se ha contactado', mail.subject
        assert_equal [ENV['EMAIL_USERNAME']], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match 'HI', mail.body.encoded
        assert_match Project.first.localized_title, mail.body.encoded
        assert_match Article.first.localized_title, mail.body.encoded
    end
end
