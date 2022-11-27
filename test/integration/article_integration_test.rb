# frozen_string_literal: true

require 'test_helper'

class ArticleIntegrationTest < ActionDispatch::IntegrationTest
    teardown do
        sign_out admins(:one)
        users(:one).update newsletter: false
    end

    setup do
        sign_in admins(:one)
        users(:one).update newsletter: true
    end

    test 'should send newsletter when creating an article' do
        parameters = {
            article: {
                status: '0'
            }
        }

        assert_emails 1 do
            post '/articles', params: parameters
        end
    end

    test 'should not send newsletter when creating an article' do
        parameters = {
            article: {
                status: '1'
            }
        }

        assert_emails 0 do
            post '/articles', params: parameters
        end
    end

    test 'should send newsletter when editing an article' do
        parameters = {
            article: {
                status: '0'
            }
        }

        assert_emails 1 do
            articles(:one).drafted!
            patch '/articles/1', params: parameters
        end
    end

    test 'should not send newsletter when editing an article' do
        parameters = {
            article: {
                status: '1'
            }
        }

        assert_emails 0 do
            articles(:one).drafted!
            patch '/articles/1', params: parameters
        end
    end
end
