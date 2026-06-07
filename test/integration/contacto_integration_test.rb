# frozen_string_literal: true

require 'test_helper'

class ContactoIntegrationTest < ActionDispatch::IntegrationTest
    teardown do
        Rails.cache.clear
    end

    test 'should block contact page after 20 attemps' do
        parameters = {
            user: {
                email: users(:one).email
            },
            message: {
                content: 'Content'
            }
        }

        10.times do
            assert_emails 2 do
                assert_difference('Message.count', 1) do
                    post '/contacto', params: parameters
                end
            end

            assert_response :found
        end

        assert_emails 0 do
            assert_no_difference('Message.count') do
                post '/contacto', params: parameters
            end
        end

        assert_response :unprocessable_entity
    end

    test 'should block contact page after 20 invalid attemps' do
        invalid_parameters = {
            user: {
                email: 'noemail'
            },
            message: {
                content: 'Content'
            }
        }
        parameters = {
            user: {
                email: users(:one).email
            },
            message: {
                content: 'Content'
            }
        }

        20.times do
            assert_emails 0 do
                assert_no_difference('Message.count') do
                    post '/contacto', params: invalid_parameters
                end
            end

            assert_response :unprocessable_entity
        end

        assert_emails 2 do
            assert_difference('Message.count', 1) do
                post '/contacto', params: parameters
            end
        end

        assert_response :found
    end
end
