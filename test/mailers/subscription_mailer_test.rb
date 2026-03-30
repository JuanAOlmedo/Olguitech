# frozen_string_literal: true

require 'test_helper'

class SubscriptionMailerTest < ActionMailer::TestCase
    setup do
        @user = users(:one)
    end

    test 'spanish confirmation instructions' do
        @user.locale = :es

        mail = SubscriptionMailer.subscribe(@user)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Suscripción a novedades de Olguitech', mail.subject
        assert_equal [@user.email], mail.to
        assert_match 'Confirmar', mail.body.encoded
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
    end

    test 'english confirmation instructions' do
        @user.locale = :en

        mail = SubscriptionMailer.subscribe(@user)

        assert_emails 1 do
            mail.deliver_now
        end

        assert_equal 'Olguitech newsletter subscription', mail.subject
        assert_equal [@user.email], mail.to
        assert_match 'Confirm', mail.body.encoded
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
    end
end
