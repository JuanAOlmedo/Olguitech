# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting the index' do
        super_categories(:two).categories << categories(:one)
        categories(:one).projects << projects(:one)
        projects(:one).drafted!

        visit projects_url
        assert_selector 'h1', text: 'Nuestros Proyectos'

        visit projects_url

        click_on 'Explorar por categoría'
        assert_no_selector 'a', text: super_categories(:one).title
        assert_no_selector 'a', text: super_categories(:two).title

        projects(:one).published!
        visit projects_url
        click_on 'Explorar por categoría'

        click_on super_categories(:two).title

        assert_selector 'h1', text: 'Nuestros Proyectos'
        assert_selector 'h2', text: categories(:one).title
        assert_selector 'h2', text: projects(:one).title

        projects(:one).drafted!
        categories(:one).projects.delete projects(:one)
        super_categories(:two).categories.delete categories(:one)
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
