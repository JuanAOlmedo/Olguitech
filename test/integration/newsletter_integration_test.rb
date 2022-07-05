# frozen_string_literal: true

require 'test_helper'

class NewsletterIntegrationTest < ActionDispatch::IntegrationTest
    teardown do
        sign_out admins(:one)
        newsletters(:one).drafted!
    end

    setup do
        users(:one).update(newsletter: true)
        sign_in admins(:one)
        newsletters(:one).drafted!
    end

    test 'should send newsletter when updating a newsletter' do
        parameters = {
            newsletter: {
                sent: '1'
            }
        }

        assert_emails 2 do
            patch '/newsletters/1', params: parameters
            newsletters(:one).send_newsletter
        end
    end

    test 'should not send newsletter when updating a newsletter' do
        parameters = {
            newsletter: {
                sent: '0'
            }
        }

        assert_emails 0 do
            patch '/newsletters/1', params: parameters
        end
    end

    test 'should send newsletter when creating a newsletter' do
        parameters = {
            newsletter: {
                sent: '1'
            }
        }

        assert_emails 1 do
            post '/newsletters', params: parameters
        end
    end

    test 'should not send newsletter when creating a newsletter' do
        parameters = {
            newsletter: {
                sent: '0'
            }
        }

        assert_emails 0 do
            post '/newsletters', params: parameters
        end
    end
end