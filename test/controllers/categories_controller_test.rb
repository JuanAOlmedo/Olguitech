# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
    setup { @category = categories(:one) }

    teardown { sign_out :admin }

    test 'should get index' do
        get categories_url
        assert_response :success
    end

    test 'should show category' do
        get category_url(id: @category.id)
        assert_response :success
    end

    test 'should not get new if not admin' do
        get new_category_url
        assert_response :redirect
    end

    test 'should get new if admin' do
        sign_in admins(:one)

        get new_category_url
        assert_response :success
    end

    test 'should not get edit if not admin' do
        get edit_category_url(id: @category.id)
        assert_response :redirect
    end

    test 'should get edit if admin' do
        sign_in admins(:one)

        get edit_category_url(id: @category.id)
        assert_response :success
    end

    test 'should not create if not admin' do
        parameters = {
            category: {
                title: 'a',
                description: 'b',
                article_ids: [''],
                project_ids: [''],
                product_ids: ['']
            }
        }

        assert_no_difference('Category.count') do
            post categories_url, params: parameters
        end
    end

    test 'should create if admin' do
        sign_in admins(:one)

        parameters = {
            category: {
                title: 'a',
                description: 'b',
                article_ids: [''],
                project_ids: [''],
                product_ids: ['']
            }
        }

        assert_difference('Category.count', 1) do
            post categories_url, params: parameters
        end
    end

    test 'should not update if not admin' do
        parameters = {
            category: {
                title: 'a',
                description: 'b',
                article_ids: [''],
                project_ids: [''],
                product_ids: ['']
            }
        }

        patch category_url(id: categories(:one)), params: parameters

        categories(:one).reload

        assert_not_equal 'a', categories(:one).title
    end

    test 'should update if admin' do
        sign_in admins(:one)

        parameters = {
            category: {
                title: 'a',
                description: 'b',
                article_ids: [''],
                project_ids: [''],
                product_ids: ['']
            }
        }

        patch category_url(id: categories(:one)), params: parameters

        categories(:one).reload

        assert_equal 'a', categories(:one).title
    end

    test 'should not delete if not admin' do
        assert_no_difference('Category.count') do
            delete category_url(id: categories(:one).id)
        end
    end

    test 'should delete if admin' do
        sign_in admins(:one)

        assert_difference('Category.count', -1) do
            delete category_url(id: categories(:one).id)
        end
    end
end
