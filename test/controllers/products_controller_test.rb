# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
    setup { @product = products(:one) }

    teardown { sign_out :admin }

    test 'should get index' do
        get products_url
        assert_response :success
    end

    test 'should not show drafted or trashed product unless admin' do
        get product_url(id: @product.id)
        assert_response :redirect

        @product.trashed!
        get product_url(id: @product.id)
        assert_response :redirect

        sign_in admins(:one)
        get product_url(id: @product.id)
        assert_response :success

        @product.drafted!
        get product_url(id: @product.id)
        assert_response :success
    end

    test 'should show published product' do
        @product.published!
        get product_url(id: @product.id)
        assert_response :success
        @product.drafted!
    end

    test 'should not get new if not admin' do
        get new_product_url
        assert_response :redirect
    end

    test 'should get new if admin' do
        sign_in admins(:one)

        get new_product_url
        assert_response :success
    end

    test 'should not get edit if not admin' do
        get edit_product_url(id: @product.id)
        assert_response :redirect
    end

    test 'should get edit if admin' do
        sign_in admins(:one)

        get edit_product_url(id: @product.id)
        assert_response :success
    end

    test 'should not create if not admin' do
        parameters = {
            product: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                proyecto_ids: [''],
                article_ids: ['']
            }
        }

        assert_no_difference('Product.count') do
            post products_url, params: parameters
        end
    end

    test 'should create if admin' do
        sign_in admins(:one)

        parameters = {
            product: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                proyecto_ids: [''],
                article_ids: ['']
            }
        }

        assert_difference('Product.count', 1) do
            post products_url, params: parameters
        end
    end

    test 'should not update if not admin' do
        parameters = {
            product: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                proyecto_ids: [''],
                article_ids: ['']
            }
        }

        patch product_url(id: products(:one)), params: parameters

        products(:one).reload

        assert_not_equal 'a', products(:one).title
    end

    test 'should update if admin' do
        sign_in admins(:one)

        parameters = {
            product: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                proyecto_ids: [''],
                article_ids: ['']
            }
        }

        patch product_url(id: products(:one)), params: parameters

        products(:one).reload

        assert_equal 'a', products(:one).title
    end

    test 'should not delete if not admin' do
        assert_no_difference('Product.count') do
            delete product_url(id: products(:one).id)
        end
    end

    test 'should delete if admin' do
        sign_in admins(:one)

        assert_difference('Product.count', -1) do
            delete product_url(id: products(:one).id)
        end
    end
end
