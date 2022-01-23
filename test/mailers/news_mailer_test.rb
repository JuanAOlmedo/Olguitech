# frozen_string_literal: true

require 'test_helper'

class NewsMailerTest < ActionMailer::TestCase
    setup do
        @user = users(:one)
        @newsletter = newsletters(:one)
    end

    test 'newsletter' do
        mail = NewsMailer.newsletter(@user, @newsletter)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Lorem Ipsum', mail.subject
        assert_equal [@user.email], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match 'Lorem Ipsum', mail.body.encoded
        assert_match 'million', mail.body.encoded
        assert_match @user.newsletter_token, mail.body.encoded
    end
end
