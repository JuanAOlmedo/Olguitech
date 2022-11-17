# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
    setup { @project = projects(:one) }

    teardown { sign_out :admin }

    test 'should get index' do
        get projects_url
        assert_response :success
    end

    test 'should not show drafted or trashed project unless admin' do
        get project_url(id: @project.id)
        assert_response :redirect

        @project.trashed!
        get project_url(id: @project.id)
        assert_response :redirect

        sign_in admins(:one)
        get project_url(id: @project.id)
        assert_response :success

        @project.drafted!
        get project_url(id: @project.id)
        assert_response :success
    end

    test 'should show published project' do
        @project.published!
        get project_url(id: @project.id)
        assert_response :success
        @project.drafted!
    end

    test 'should not get new if not admin' do
        get new_project_url
        assert_response :redirect
    end

    test 'should get new if admin' do
        sign_in admins(:one)

        get new_project_url
        assert_response :success
    end

    test 'should not get edit if not admin' do
        get edit_project_url(id: @project.id)
        assert_response :redirect
    end

    test 'should get edit if admin' do
        sign_in admins(:one)

        get edit_project_url(id: @project.id)
        assert_response :success
    end

    test 'should not create if not admin' do
        parameters = {
            project: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        assert_no_difference('Project.count') do
            post projects_url, params: parameters
        end
    end

    test 'should create if admin' do
        sign_in admins(:one)

        parameters = {
            project: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        assert_difference('Project.count', 1) do
            post projects_url, params: parameters
        end
    end

    test 'should not update if not admin' do
        parameters = {
            project: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        patch project_url(id: projects(:one)), params: parameters

        projects(:one).reload

        assert_not_equal 'a', projects(:one).title
    end

    test 'should update if admin' do
        sign_in admins(:one)

        parameters = {
            project: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        patch project_url(id: projects(:one)), params: parameters

        projects(:one).reload

        assert_equal 'a', projects(:one).title
    end

    test 'should not delete if not admin' do
        assert_no_difference('Project.count') do
            delete project_url(id: projects(:one).id)
        end
    end

    test 'should delete if admin' do
        sign_in admins(:one)

        assert_difference('Project.count', -1) do
            delete project_url(id: projects(:one).id)
        end
    end
end
