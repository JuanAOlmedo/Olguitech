require 'test_helper'

class ConfirmationMailerTest < ActionMailer::TestCase
    setup do 
        @user = users(:one)
    end

    test 'confirmation instructions' do
        mail = ConfirmationMailer.confirmation_instructions(@user)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Olguitech s.a.s.', mail.subject
        assert_equal [@user.email], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
    end
end