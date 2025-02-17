# frozen_string_literal: true

require 'test_helper'

class MainsControllerTest < ActionDispatch::IntegrationTest
    test 'should show main' do
        get '/'
        assert_response :success
    end

    test 'should get contacto' do
        get '/contacto'
        assert_response :success
    end

    test 'should get nosotros' do
        get nosotros_path
        assert_response :success
    end

    test 'should create user' do
        assert_difference('User.count', 1) do
            post '/users/subscribe', params: { user: { email: 'test10@test.com' } }
        end

        assert_equal true, User.last.newsletter
        assert_response :redirect
    end

    test 'should subscribe user' do
        users(:one).update! newsletter: false

        assert_difference('User.count', 0) do
            post '/users/subscribe', params: { user: { email: users(:one).email } }
        end

        users(:one).reload
        assert_equal true, users(:one).newsletter

        assert_response :redirect

        assert_difference('User.count', 1) do
            post '/users/subscribe', params: { user: { email: 'test@tesst.com' } }
        end
    end
end
