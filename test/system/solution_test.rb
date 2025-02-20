# frozen_string_literal: true

require 'application_system_test_case'

class SolutionsTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting the index' do
        visit solutions_url
        assert_selector 'h1', text: 'Nuestras Soluciones'
    end

    test 'visiting an solution' do
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
