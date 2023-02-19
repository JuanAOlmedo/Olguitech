# frozen_string_literal: true

require 'test_helper'

class SuperCategoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
        @super_category = super_categories(:one)
    end

    teardown do
        sign_out admins(:one)
    end

    test 'should get new' do
        get new_super_category_url
        assert_response :redirect

        sign_in admins(:one)

        get new_super_category_url
        assert_response :success
    end

    test 'should create super_category' do
        assert_difference('SuperCategory.count', 0) do
            post super_categories_url, params: { super_category: { title: '' } }
        end

        sign_in admins(:one)

        assert_difference('SuperCategory.count') do
            post super_categories_url, params: { super_category: { title: '' } }
        end
    end

    test 'should get edit' do
        get '/super_categories/1/edit'
        assert_response :redirect

        sign_in admins(:one)

        get '/super_categories/1/edit'
        assert_response :success
    end

    test 'should update super_category' do
        patch '/super_categories/1', params: { super_category: { title: 'edit', title2: 'edit2' } }
        assert_redirected_to '/admins/sign_in'

        sign_in admins(:one)

        patch '/super_categories/1', params: { super_category: { title: 'edit', title2: 'edit2' } }
        assert_redirected_to '/es/dashboard/categories'
        @super_category.reload
        assert_equal @super_category.title, 'edit'
    end

    test 'should destroy super_category' do
        assert_difference('SuperCategory.count', 0) do
            delete '/super_categories/1'
        end
        assert_redirected_to '/admins/sign_in'

        sign_in admins(:one)

        assert_difference('SuperCategory.count', -1) do
            delete '/super_categories/1'
        end
        assert_redirected_to '/es/dashboard/categories'
    end
end
