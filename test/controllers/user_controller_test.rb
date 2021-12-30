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

    test "should not update user without token" do
        patch '/users/1', params: { user: { name: "Lorem Ipsum", phone: "000 000 000", company: "Olguitech" } }

        assert_response :unauthorized
        users(:one).reload
        assert_equal "Juan Andres Olmedo", users(:one).name
        
        patch '/users/1', params: { user: { name: "Lorem Ipsum", phone: "000 000 000", company: "Olguitech", edit_token: users(:one).edit_token } }

        assert_response :success
        users(:one).reload
        assert_equal "Lorem Ipsum", users(:one).name
    end
end
