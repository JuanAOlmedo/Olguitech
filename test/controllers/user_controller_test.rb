require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
    test "should not get index if not admin" do
        get '/users'
        assert_response :redirect
    end

    test "should get index if admin" do
        sign_in admins(:one)

        get '/users'
        assert_response :success

        sign_out :admin
    end

    test "should not get new if not admin" do
        get '/users/new'
        assert_response :redirect
    end

    test "should get new if admin" do
        sign_in admins(:one)

        get '/users/new'
        assert_response :success

        sign_out :admin
    end

    test 'should not create if not admin' do
        parameters = {
            email: "tests5@test.com"
        }

        assert_no_difference('User.count') do
            post users_url, params: parameters
        end
    end

    test 'should create if admin' do
        sign_in admins(:one)

        parameters = {
            email: "tests5@test.com"
        }

        assert_difference('User.count', 1) do
            post users_url, params: parameters
        end

        sign_out :admin
    end

    test "shoud not get edit without token" do
        get "/users/1/edit"
        assert_response :redirect
    end

    test "shoud get edit with token" do
        get "/users/1/edit/#{users(:one).edit_token}"
        assert_response :success
    end

    test "should not update user without token" do
        patch '/users/1', params: { user: { name: "Lorem Ipsum", phone: "000 000 000", company: "Olguitech" } }
        assert_response :redirect

        users(:one).reload
        assert_equal "Juan Andres Olmedo", users(:one).name
    end

    test "should update user with token" do
        patch '/users/1', params: { user: { name: "Lorem Ipsum", phone: "000 000 000", company: "Olguitech", edit_token: users(:one).edit_token } }
        assert_response :success

        users(:one).reload
        assert_equal "Lorem Ipsum", users(:one).name
    end

    test "should not destroy user without token" do
        assert_no_difference('User.count') do
            delete '/users/1'
        end

        assert_response :redirect
    end

    test "should destroy user with token" do
        assert_difference('User.count', -1) do
            delete "/users/1/#{users(:one).edit_token}"
        end

        assert_response :see_other
    end
end
