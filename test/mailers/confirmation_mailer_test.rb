require 'test_helper'

class ConfirmationMailerTest < ActionMailer::TestCase
    setup do 
        @user = users(:one)
    end

    test 'spanish confirmation instructions' do
        @user.locale = :es

        mail = ConfirmationMailer.confirmation_instructions(@user)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Confirmá tu cuenta!', mail.subject
        assert_equal [@user.email], mail.to
        assert_match "Confirmar", mail.body.encoded
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
    end

    test 'english confirmation instructions' do
        @user.locale = :en

        mail = ConfirmationMailer.confirmation_instructions(@user)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Confirm your account!', mail.subject
        assert_equal [@user.email], mail.to
        assert_match "Confirm", mail.body.encoded
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
    end
end