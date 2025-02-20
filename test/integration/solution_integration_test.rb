# frozen_string_literal: true

require 'test_helper'

class SolutionIntegrationTest < ActionDispatch::IntegrationTest
    teardown do
        sign_out admins(:one)
        users(:one).update newsletter: false
    end

    setup do
        sign_in admins(:one)
        users(:one).update newsletter: true
    end

    test 'should send newsletter when creating an solution' do
        parameters = {
            solution: {
                status: '0'
            }
        }

        assert_emails 1 do
            post '/solutions', params: parameters
        end
    end

    test 'should not send newsletter when creating an solution' do
        parameters = {
            solution: {
                status: '1'
            }
        }

        assert_emails 0 do
            post '/solutions', params: parameters
        end
    end

    test 'should send newsletter when editing an solution' do
        parameters = {
            solution: {
                status: '0'
            }
        }

        assert_emails 1 do
            solutions(:one).drafted!
            patch '/solutions/1', params: parameters
        end
    end

    test 'should not send newsletter when editing an solution' do
        parameters = {
            solution: {
                status: '1'
            }
        }

        assert_emails 0 do
            solutions(:one).drafted!
            patch '/solutions/1', params: parameters
        end
    end
end
