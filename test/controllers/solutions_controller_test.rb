# frozen_string_literal: true

require 'test_helper'

class SolutionsControllerTest < ActionDispatch::IntegrationTest
    setup { @solution = solutions(:one) }

    teardown { sign_out :admin }

    test 'should get index' do
        get solutions_url
        assert_response :success
    end

    test 'should not show drafted or trashed solution unless admin' do
        get solution_url(id: @solution.id)
        assert_response :redirect

        @solution.trashed!
        get solution_url(id: @solution.id)
        assert_response :redirect

        sign_in admins(:one)
        get solution_url(id: @solution.id)
        assert_response :success

        @solution.drafted!
        get solution_url(id: @solution.id)
        assert_response :success
    end

    test 'should show published solution' do
        @solution.published!
        get solution_url(id: @solution.id)
        assert_response :success
        @solution.drafted!
    end

    test 'should not get new if not admin' do
        get new_solution_url
        assert_response :redirect
    end

    test 'should get new if admin' do
        sign_in admins(:one)

        get new_solution_url
        assert_response :success
    end

    test 'should not get edit if not admin' do
        get edit_solution_url(id: @solution.id)
        assert_response :redirect
    end

    test 'should get edit if admin' do
        sign_in admins(:one)

        get edit_solution_url(id: @solution.id)
        assert_response :success
    end

    test 'should not create if not admin' do
        parameters = {
            solution: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        assert_no_difference('Solution.count') do
            post solutions_url, params: parameters
        end
    end

    test 'should create if admin' do
        sign_in admins(:one)

        parameters = {
            solution: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        assert_difference('Solution.count', 1) do
            post solutions_url, params: parameters
        end
    end

    test 'should not update if not admin' do
        parameters = {
            solution: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        patch solution_url(id: solutions(:one)), params: parameters

        solutions(:one).reload

        assert_not_equal 'a', solutions(:one).title
    end

    test 'should update if admin' do
        sign_in admins(:one)

        parameters = {
            solution: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        patch solution_url(id: solutions(:one)), params: parameters

        solutions(:one).reload

        assert_equal 'a', solutions(:one).title
    end

    test 'should not delete if not admin' do
        assert_no_difference('Solution.count') do
            delete solution_url(id: solutions(:one).id)
        end
    end

    test 'should delete if admin' do
        sign_in admins(:one)

        assert_difference('Solution.count', -1) do
            delete solution_url(id: solutions(:one).id)
        end
    end
end
