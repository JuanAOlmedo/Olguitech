# frozen_string_literal: true

require 'application_system_test_case'

class ProductsTest < ApplicationSystemTestCase
    teardown { sign_out :admin }
    
    test 'visiting the index' do
        visit products_url
        assert_selector 'h1', text: 'Nuestros Productos'
    end

    test 'visiting an article' do
        visit '/products/1'
        assert_selector 'h1', text: products(:one).title
    end

    test 'should create article' do
        sign_in admins(:one)

        visit '/products/new'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'product_category_ids_1'

        assert_difference('Product.count', 1) do
            click_on 'Crear'
        end
    end

    test 'should edit article' do
        sign_in admins(:one)

        visit '/products/1/edit'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'product_category_ids_1'

        click_on 'Crear'

        products(:one).reload
        assert_equal 'A Title', products(:one).title
    end
end
