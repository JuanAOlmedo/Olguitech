require 'test_helper'

class NewslettersControllerTest < ActionDispatch::IntegrationTest
    setup do
        @newsletter = newsletters(:one)
        @params = { newsletter: { title: 'a', subject: 'b' } }
    end

    test 'should not get/post anything' do
        get newsletters_url
        assert_response :redirect

        get new_newsletter_url
        assert_response :redirect

        get newsletter_url(id: @newsletter.id)
        assert_response :redirect

        assert_no_difference('Newsletter.count') do
            post newsletters_url, params: @params
        end
    end

    test 'should get/post everything if admin' do
        sign_in admins(:one)

        get newsletters_url
        assert_response :success

        get new_newsletter_url
        assert_response :success

        get newsletter_url(id: @newsletter.id)
        assert_response :success

        assert_difference('Newsletter.count', 1) do
            post newsletters_url, params: @params
        end

        sign_out :admin
    end
end
