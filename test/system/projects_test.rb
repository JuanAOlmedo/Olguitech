# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting the index' do
        visit projects_url
        assert_selector 'h1', text: 'Nuestros Proyectos'
    end

    test 'visiting an article' do
        projects(:one).published!
        visit '/projects/1'
        assert_selector 'h1', text: projects(:one).title
    end

    test 'should create article' do
        sign_in admins(:one)

        visit '/projects/new'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'project_category_ids_1'

        assert_difference('Project.count', 1) do
            click_on 'Crear'
        end
    end

    test 'should edit article' do
        sign_in admins(:one)

        visit '/projects/1/edit'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'project_category_ids_1'

        click_on 'Crear'

        projects(:one).reload
        assert_equal 'A Title', projects(:one).title
    end
end
