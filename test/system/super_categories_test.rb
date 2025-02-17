# frozen_string_literal: true

require 'application_system_test_case'

class SuperCategoriesTest < ApplicationSystemTestCase
    setup do
        @super_category = super_categories(:one)
    end

    teardown { sign_out :admin }

    test 'should create super category' do
        sign_in admins(:one)

        visit '/super_categories/new'

        fill_in 'Título', with: 'A Title'
        check id: 'super_category_category_ids_1'

        assert_difference('SuperCategory.count', 1) do
            click_on 'Crear'
        end

        assert_equal 'A Title', SuperCategory.last.title
        assert_equal categories(:one), SuperCategory.last.categories.first
    end

    test 'should edit super category' do
        sign_in admins(:one)

        visit '/super_categories/1/edit'

        fill_in 'Título', with: 'A Title1'
        uncheck id: 'super_category_category_ids_1'

        click_on 'Crear'

        @super_category.reload
        assert_equal 'A Title1', @super_category.title
        assert_equal 0, @super_category.categories.count
    end
end
