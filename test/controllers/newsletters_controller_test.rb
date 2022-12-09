# frozen_string_literal: true

require 'test_helper'

class NewslettersControllerTest < ActionDispatch::IntegrationTest
    setup do
        @newsletter = newsletters(:one)
        @params = { newsletter: { title: 'a', subject: 'b' } }
    end

    test 'should not get/post anything except show' do
        get newsletters_url
        assert_response :redirect

        get new_newsletter_url
        assert_response :redirect

        @newsletter.sent!
        get newsletter_url(id: @newsletter.id)
        assert_response :success
        @newsletter.drafted!

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

        assert_difference('Newsletter.count', 1) do
            post newsletters_url, params: @params
        end

        sign_out :admin
    end

    test 'should not edit/update/destroy newsletter if sent' do
        sign_in admins(:one)
        @newsletter.sent!

        get '/newsletters/1/edit'
        assert_response :redirect

        patch '/newsletters/1', params: @params
        @newsletter.reload
        assert_not_equal 'a', @newsletter.title

        assert_no_difference('Newsletter.count') do
            delete '/newsletters/1'
        end

        sign_out :admin
        @newsletter.drafted!
    end

    test 'should edit/update/destroy newsletter if drafted' do
        sign_in admins(:one)
        @newsletter.drafted!

        get '/newsletters/1/edit'
        assert_response :success

        patch '/newsletters/1', params: @params
        @newsletter.reload
        assert_equal 'a', @newsletter.title

        assert_difference('Newsletter.count', -1) do
            delete '/newsletters/1'
        end

        sign_out :admin
    end
end
