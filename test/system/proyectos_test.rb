# frozen_string_literal: true

require 'application_system_test_case'

class ProyectosTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting the index' do
        visit proyectos_url
        assert_selector 'h1', text: 'Nuestros Proyectos'
    end

    test 'visiting an article' do
        visit '/proyectos/1'
        assert_selector 'h1', text: proyectos(:one).title
    end

    test 'should create article' do
        sign_in admins(:one)

        visit '/proyectos/new'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'proyecto_category_ids_1'

        assert_difference('Proyecto.count', 1) do
            click_on 'Crear'
        end
    end

    test 'should edit article' do
        sign_in admins(:one)

        visit '/proyectos/1/edit'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'proyecto_category_ids_1'

        click_on 'Crear'

        proyectos(:one).reload
        assert_equal 'A Title', proyectos(:one).title
    end
end
