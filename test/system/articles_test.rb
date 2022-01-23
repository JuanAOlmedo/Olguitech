# frozen_string_literal: true

require 'application_system_test_case'

class ArticlesTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting the index' do
        visit articles_url
        assert_selector 'h1', text: 'Nuestras Soluciones'
    end

    test 'visiting an article' do
        visit '/articles/1'
        assert_selector 'h1', text: articles(:one).title
    end

    test 'should create article' do
        sign_in admins(:one)

        visit '/articles/new'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'article_category_ids_1'

        assert_difference('Article.count', 1) do
            click_on 'Crear'
        end
    end

    test 'should edit article' do
        sign_in admins(:one)

        visit '/articles/1/edit'

        fill_in 'Título', with: 'A Title'
        fill_in 'Descripción', with: 'Desc'
        check id: 'article_category_ids_1'

        click_on 'Crear'

        articles(:one).reload
        assert_equal 'A Title', articles(:one).title
    end
end
