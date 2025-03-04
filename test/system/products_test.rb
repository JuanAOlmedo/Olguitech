# frozen_string_literal: true

require 'application_system_test_case'

class ProductsTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting the index' do
        super_categories(:two).categories << categories(:one)
        categories(:one).products << products(:one)
        products(:one).drafted!

        visit products_url
        assert_selector 'h1', text: 'Nuestros Productos'

        visit products_url

        click_on 'Explorar por categoría'
        assert_no_selector 'a', text: super_categories(:one).title
        assert_no_selector 'a', text: super_categories(:two).title

        products(:one).published!
        visit products_url
        click_on 'Explorar por categoría'

        click_on super_categories(:two).title

        assert_selector 'h1', text: 'Nuestros Productos'
        assert_selector 'h2', text: categories(:one).title
        assert_selector 'h2', text: products(:one).title

        products(:one).drafted!
        categories(:one).products.delete products(:one)
        super_categories(:two).categories.delete categories(:one)
    end

    test 'visiting an article' do
        products(:one).published!
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
