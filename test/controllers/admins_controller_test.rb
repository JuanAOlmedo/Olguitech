# frozen_string_literal: true

require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
    test 'should not be able to create admin if not admin' do
        post '/admins',
             params: { admin: { email: 'tests2@test.com', password: 'superstrongpassword',
                                password_confirmation: 'superstrongpassword' } }

        assert_response :redirect
        assert_equal [admins(:one)], admins
    end
end
