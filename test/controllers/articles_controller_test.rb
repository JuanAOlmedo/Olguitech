# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
    setup { @article = articles(:one) }

    teardown { sign_out :admin }

    test 'should get index' do
        get articles_url
        assert_response :success
    end

    test 'should show article' do
        get article_url(id: @article.id)
        assert_response :success
    end

    test 'should not get new if not admin' do
        get new_article_url
        assert_response :redirect
    end

    test 'should get new if admin' do
        sign_in admins(:one)

        get new_article_url
        assert_response :success
    end

    test 'should not get edit if not admin' do
        get edit_article_url(id: @article.id)
        assert_response :redirect
    end

    test 'should get edit if admin' do
        sign_in admins(:one)

        get edit_article_url(id: @article.id)
        assert_response :success
    end

    test 'should not create if not admin' do
        parameters = {
            article: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        assert_no_difference('Article.count') do
            post articles_url, params: parameters
        end
    end

    test 'should create if admin' do
        sign_in admins(:one)

        parameters = {
            article: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        assert_difference('Article.count', 1) do
            post articles_url, params: parameters
        end
    end

    test 'should not update if not admin' do
        parameters = {
            article: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        patch article_url(id: articles(:one)), params: parameters

        articles(:one).reload

        assert_not_equal 'a', articles(:one).title
    end

    test 'should update if admin' do
        sign_in admins(:one)

        parameters = {
            article: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        patch article_url(id: articles(:one)), params: parameters

        articles(:one).reload

        assert_equal 'a', articles(:one).title
    end

    test 'should not delete if not admin' do
        assert_no_difference('Article.count') do
            delete article_url(id: articles(:one).id)
        end
    end

    test 'should delete if admin' do
        sign_in admins(:one)

        assert_difference('Article.count', -1) do
            delete article_url(id: articles(:one).id)
        end
    end
end
