# frozen_string_literal: true

require 'application_system_test_case'

class SuperCategoriesTest < ApplicationSystemTestCase
    setup do
        @super_category = super_categories(:one)
    end

    test 'visiting the index' do
        visit super_categories_url
        assert_selector 'h1', text: 'Super categories'
    end

    test 'should create super category' do
        visit super_categories_url
        click_on 'New super category'

        click_on 'Create Super category'

        assert_text 'Super category was successfully created'
        click_on 'Back'
    end

    test 'should update Super category' do
        visit super_category_url(@super_category)
        click_on 'Edit this super category', match: :first

        click_on 'Update Super category'

        assert_text 'Super category was successfully updated'
        click_on 'Back'
    end

    test 'should destroy Super category' do
        visit super_category_url(@super_category)
        click_on 'Destroy this super category', match: :first

        assert_text 'Super category was successfully destroyed'
    end
end
