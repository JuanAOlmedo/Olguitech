# frozen_string_literal: true

require 'application_system_test_case'

class SolutionsTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting the index' do
        super_categories(:one).categories << categories(:one)
        categories(:one).solutions << solutions(:one)
        solutions(:one).drafted!

        visit solutions_url
        assert_selector 'h1', text: 'Nuestras Soluciones'

        visit solutions_url

        click_on 'Explorar por categoría'
        assert_no_selector 'a', text: super_categories(:one).title
        assert_no_selector 'a', text: super_categories(:two).title

        solutions(:one).published!
        visit solutions_url
        click_on 'Explorar por categoría'

        click_on super_categories(:one).title

        assert_selector 'h1', text: 'Nuestras Soluciones'
        assert_selector 'h2', text: categories(:one).title
        assert_selector 'h2', text: solutions(:one).title

        solutions(:one).drafted!
        categories(:one).solutions.delete solutions(:one)
        super_categories(:one).categories.delete categories(:one)
    end

    test 'visiting a solution' do
        solutions(:one).published!
        visit '/solutions/1'
        assert_selector 'h1', text: solutions(:one).title
    end

    test 'should create solution' do
        sign_in admins(:one)

        visit '/solutions/new'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'solution_category_ids_1'

        assert_difference('Solution.count', 1) do
            click_on 'Crear'
        end
    end

    test 'should edit solution' do
        sign_in admins(:one)

        visit '/solutions/1/edit'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'solution_category_ids_1'

        click_on 'Crear'

        solutions(:one).reload
        assert_equal 'A Title', solutions(:one).title
    end
end
