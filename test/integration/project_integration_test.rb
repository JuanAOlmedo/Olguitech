# frozen_string_literal: true

require 'test_helper'

class ProjectIntegrationTest < ActionDispatch::IntegrationTest
    teardown do
        sign_out admins(:one)
        users(:one).update newsletter: false
    end

    setup do
        sign_in admins(:one)
        users(:one).update newsletter: true
    end

    test 'should send newsletter when creating a project' do
        parameters = {
            project: {
                status: :published
            }
        }

        assert_emails 1 do
            post '/projects', params: parameters
        end
    end

    test 'should not send newsletter when creating a project' do
        parameters = {
            project: {
                status: :drafted
            }
        }

        assert_emails 0 do
            post '/projects', params: parameters
        end
    end

    test 'should send newsletter when editing a project' do
        parameters = {
            project: {
                status: :published
            }
        }

        assert_emails 1 do
            projects(:one).drafted!
            patch '/projects/1', params: parameters
        end
    end

    test 'should not send newsletter when editing a project' do
        parameters = {
            project: {
                status: :drafted
            }
        }

        assert_emails 0 do
            projects(:one).drafted!
            patch '/projects/1', params: parameters
        end
    end
end
