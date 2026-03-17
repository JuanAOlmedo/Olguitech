# frozen_string_literal: true

require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
    test 'should not get index if not admin' do
        get '/users'
        assert_response :redirect
    end

    test 'should get index if admin' do
        sign_in admins(:one)

        get '/users'
        assert_response :success

        sign_out :admin
    end

    test 'should not get new if not admin' do
        get '/users/new'
        assert_response :redirect
    end

    test 'should get new if admin' do
        sign_in admins(:one)

        get '/users/new'
        assert_response :success

        sign_out :admin
    end

    test 'should not create if not admin' do
        parameters = {
            user: {
                email: 'tests5@test.com'
            }
        }

        assert_no_difference('User.count') do
            post users_url, params: parameters
        end
    end

    test 'should create if admin' do
        sign_in admins(:one)

        parameters = {
            user: {
                email: 'tests5@test.com'
            }
        }

        assert_difference('User.count', 1) do
            post users_url, params: parameters
        end

        sign_out :admin
    end

    test 'shoud not get edit without token' do
        get '/users/1/edit'
        assert_response :redirect
    end

    test 'shoud get edit with token' do
        get "/users/1/edit/#{users(:one).edit_token}"
        assert_response :success
    end

    test 'should not update user without token' do
        patch '/users/1',
              params: { user: { name: 'Lorem Ipsum', phone: '000 000 000', company: 'Olguitech' } }
        assert_response :redirect

        users(:one).reload
        assert_equal 'Juan Andres Olmedo', users(:one).name
    end

    test 'should update user with token' do
        patch '/users/1',
              params: { user: { name: 'Lorem Ipsum', phone: '000 000 000', company: 'Olguitech',
                                edit_token: users(:one).edit_token } }
        assert_response :redirect

        users(:one).reload
        assert_equal 'Lorem Ipsum', users(:one).name
    end

    test 'should not destroy user without token' do
        assert_no_difference('User.count') do
            delete '/users/1'
        end

        assert_response :redirect
    end

    test 'should destroy user with token' do
        assert_difference('User.count', -1) do
            delete "/users/1/#{users(:one).edit_token}"
        end

        assert_response :see_other
    end

    test 'should confirm user with valid token' do
        user = users(:unconfirmed)

        get "/es/users/confirmation/#{user.confirmation_token}"

        assert_redirected_to root_path
        I18n.locale = :es
        assert_equal I18n.t('confirmed'), flash[:notice]
        assert user.reload.confirmed?
    end

    test 'should not confirm user with invalid token' do
        get '/es/users/confirmation/invalid_token'

        assert_redirected_to root_path
        I18n.locale = :es
        assert_equal I18n.t('link_broken'), flash[:alert]
    end


    test 'should unsubscribe user with valid token' do
        user = users(:one)
        user.update(locale: :es)
        I18n.locale = :es

        get unsubscribe_users_path(newsletter_token: user.newsletter_token)

        assert_redirected_to root_path
        assert_equal I18n.t('unsubscribed'), flash[:notice]
        assert_not user.reload.newsletter
    end

    test 'should not unsubscribe user with invalid token' do
        I18n.locale = :es
        get unsubscribe_users_path(newsletter_token: 'invalid_token', locale: :es)

        assert_redirected_to root_path
        assert_equal I18n.t('link_broken'), flash[:alert]
    end
end
