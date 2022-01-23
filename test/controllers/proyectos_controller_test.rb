# frozen_string_literal: true

require 'test_helper'

class ProyectosControllerTest < ActionDispatch::IntegrationTest
    setup { @proyecto = proyectos(:one) }

    teardown { sign_out :admin }

    test 'should get index' do
        get proyectos_url
        assert_response :success
    end

    test 'should show proyecto' do
        get proyecto_url(id: @proyecto.id)
        assert_response :success
    end

    test 'should not get new if not admin' do
        get new_proyecto_url
        assert_response :redirect
    end

    test 'should get new if admin' do
        sign_in admins(:one)

        get new_proyecto_url
        assert_response :success
    end

    test 'should not get edit if not admin' do
        get edit_proyecto_url(id: @proyecto.id)
        assert_response :redirect
    end

    test 'should get edit if admin' do
        sign_in admins(:one)

        get edit_proyecto_url(id: @proyecto.id)
        assert_response :success
    end

    test 'should not create if not admin' do
        parameters = {
            proyecto: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        assert_no_difference('Proyecto.count') do
            post proyectos_url, params: parameters
        end
    end

    test 'should create if admin' do
        sign_in admins(:one)

        parameters = {
            proyecto: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        assert_difference('Proyecto.count', 1) do
            post proyectos_url, params: parameters
        end
    end

    test 'should not update if not admin' do
        parameters = {
            proyecto: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        patch proyecto_url(id: proyectos(:one)), params: parameters

        proyectos(:one).reload

        assert_not_equal 'a', proyectos(:one).title
    end

    test 'should update if admin' do
        sign_in admins(:one)

        parameters = {
            proyecto: {
                title: 'a',
                description: 'b',
                category_ids: [''],
                product_ids: ['']
            }
        }

        patch proyecto_url(id: proyectos(:one)), params: parameters

        proyectos(:one).reload

        assert_equal 'a', proyectos(:one).title
    end

    test 'should not delete if not admin' do
        assert_no_difference('Proyecto.count') do
            delete proyecto_url(id: proyectos(:one).id)
        end
    end

    test 'should delete if admin' do
        sign_in admins(:one)

        assert_difference('Proyecto.count', -1) do
            delete proyecto_url(id: proyectos(:one).id)
        end
    end
end
