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
end
