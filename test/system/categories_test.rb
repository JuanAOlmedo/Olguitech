# frozen_string_literal: true

require 'application_system_test_case'

class CategoriesTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting a category' do
        visit '/categories/1'
        assert_selector 'h1', text: categories(:one).title
        assert_selector 'a', text: categories(:two).title
    end

    test 'should create category' do
        sign_in admins(:one)

        visit '/categories/new'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'category_solution_ids_1'

        assert_difference('Category.count', 1) do
            click_on 'Crear'
        end
    end

    test 'should edit article' do
        sign_in admins(:one)

        visit '/categories/1/edit'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'category_solution_ids_1'

        click_on 'Crear'

        categories(:one).reload
        assert_equal 'A Title', categories(:one).title
    end
end
