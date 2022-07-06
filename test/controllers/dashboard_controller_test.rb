# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
    test 'should get everything if admin' do
        sign_in admins(:one)

        get '/dashboard'
        assert_response :success
        get '/dashboard/categories'
        assert_response :success
        get '/dashboard/newsletters'
        assert_response :success
        get '/dashboard/edit'
        assert_response :success
        get '/dashboard/trash'
        assert_response :success
        get '/dashboard/users'
        assert_response :success

        sign_out admins(:one)
    end

    test 'should not get anything if not admin' do
        get '/dashboard'
        assert_response :redirect
        get '/dashboard/categories'
        assert_response :redirect
        get '/dashboard/newsletters'
        assert_response :redirect
        get '/dashboard/edit'
        assert_response :redirect
        get '/dashboard/trash'
        assert_response :redirect
        get '/dashboard/users'
        assert_response :redirect
    end
end
