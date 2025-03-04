# frozen_string_literal: true

require 'test_helper'

class ProductIntegrationTest < ActionDispatch::IntegrationTest
    teardown do
        sign_out admins(:one)
        users(:one).update newsletter: false
    end

    setup do
        sign_in admins(:one)
        users(:one).update newsletter: true
    end

    test 'should send newsletter when creating an product' do
        parameters = {
            product: {
                status: :published
            }
        }

        assert_emails 1 do
            post '/products', params: parameters
        end
    end

    test 'should not send newsletter when creating an product' do
        parameters = {
            product: {
                status: :drafted
            }
        }

        assert_emails 0 do
            post '/products', params: parameters
        end
    end

    test 'should send newsletter when editing an product' do
        parameters = {
            product: {
                status: :published
            }
        }

        assert_emails 1 do
            products(:one).drafted!
            patch '/products/1', params: parameters
        end
    end

    test 'should not send newsletter when editing an product' do
        parameters = {
            product: {
                status: :drafted
            }
        }

        assert_emails 0 do
            products(:one).drafted!
            patch '/products/1', params: parameters
        end
    end
end
