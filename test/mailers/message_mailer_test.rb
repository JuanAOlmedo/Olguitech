# frozen_string_literal: true

require 'test_helper'

class MessageMailerTest < ActionMailer::TestCase
    setup do
        @user = users(:one)
        @message = @user.messages.create(content: 'HI')
    end

    test 'user_message' do
        @user.update(locale: :es)
        mail = MessageMailer.user_mail(@user, @message)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Recibimos su mensaje — Olguitech', mail.subject
        assert_equal [@user.email], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match 'HI', mail.body.encoded
    end

    test 'admin_message' do
        mail = MessageMailer.admin_mail(@user, @message)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Una nueva persona se contactó', mail.subject
        assert_equal [ENV['EMAIL_USERNAME']], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match 'HI', mail.body.encoded
    end
end
