# frozen_string_literal: true

require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
    setup { sign_in admins(:one) }

    teardown { sign_out admins(:one) }

    test 'visiting the dashboard for articles and publishing and drafting solutions' do
        solutions(:one).drafted!
        visit '/dashboard'
        assert_selector 'h1', text: 'Todos los artículos'

        find("#drafted_solutions ##{dom_id solutions(:one)}").find('.btn', text: 'Publicar').click
        solutions(:one).reload
        assert_equal solutions(:one).status, 'published'

        find("#published_solutions ##{dom_id solutions(:one)}").find('.btn', text: 'Despublicar').click
        solutions(:one).reload
        assert_equal solutions(:one).status, 'drafted'

        find("#drafted_solutions ##{dom_id solutions(:one)}").find('.btn', text: 'Mover a la papelera').click
        solutions(:one).reload
        assert_equal solutions(:one).status, 'trashed'

        assert_no_selector 'h3', text: solutions(:one).title

        solutions(:one).drafted!
    end

    test 'visiting the dashboard for articles and publishing and drafting projects' do
        projects(:one).drafted!
        visit '/dashboard'
        assert_selector 'h1', text: 'Todos los artículos'

        find("#drafted_projects ##{dom_id projects(:one)}").find('.btn', text: 'Publicar').click
        projects(:one).reload
        assert_equal projects(:one).status, 'published'

        find("#published_projects ##{dom_id projects(:one)}").find('.btn', text: 'Despublicar').click
        projects(:one).reload
        assert_equal projects(:one).status, 'drafted'

        find("#drafted_projects ##{dom_id projects(:one)}").find('.btn', text: 'Mover a la papelera').click
        projects(:one).reload
        assert_equal projects(:one).status, 'trashed'

        assert_no_selector 'h3', text: projects(:one).title

        projects(:one).drafted!
    end

    test 'visiting the dashboard for articles and publishing and drafting products' do
        products(:one).drafted!
        visit '/dashboard'
        assert_selector 'h1', text: 'Todos los artículos'

        find("#drafted_products ##{dom_id products(:one)}").find('.btn', text: 'Publicar').click
        products(:one).reload
        assert_equal products(:one).status, 'published'

        find("#published_products ##{dom_id products(:one)}").find('.btn', text: 'Despublicar').click
        products(:one).reload
        assert_equal products(:one).status, 'drafted'

        find("#drafted_products ##{dom_id products(:one)}").find('.btn', text: 'Mover a la papelera').click
        products(:one).reload
        assert_equal products(:one).status, 'trashed'

        assert_no_selector 'h3', text: products(:one).title

        products(:one).drafted!
    end

    test 'visiting the dashboard for users' do
        visit '/dashboard/users'

        assert_selector 'h1', text: 'Usuarios'
        assert_selector 'a', text: users(:one).email
    end

    test 'visiting the dashboard for categories and destroying categories' do
        category = Category.create title: 'Destroy me'
        visit '/dashboard/categories'

        assert_selector 'h1', text: 'Destroy me'

        assert_difference 'Category.count', -1 do
            accept_confirm { find("##{dom_id category}").click_on 'Eliminar' }
        end

        assert_no_selector 'h1', text: 'Destroy me'
    end

    test 'visiting the dashboard for categories and destroying super categories' do
        SuperCategory.create title: 'Destroy me', id: 5
        visit '/dashboard/categories'

        assert_selector 'h1', text: 'Destroy me'

        assert_difference 'SuperCategory.count', -1 do
            accept_confirm { find('#super_category_5').click_on 'Eliminar' }
            # This test wouldn't work without the sleep (maybe because of
            # dependent: :nullify in the SuperCategory model)
            sleep 1
        end

        assert_no_selector 'h1', text: 'Destroy me'
    end

    test 'visiting the dashboard for categories and unrelating articles' do
        solutions(:one).drafted!
        projects(:one).drafted!
        products(:one).drafted!

        categories(:one).solutions << solutions(:one)
        categories(:one).projects << projects(:one)
        categories(:one).products << products(:one)
        visit '/dashboard/categories'

        assert_difference 'Category.first.solutions.count', -1 do
            find("##{dom_id categories(:one)}").find("##{dom_id solutions(:one)}").click_on 'Desasociar'
        end
        assert_selector '#uncategorized_big_card h3', text: solutions(:one).title

        assert_difference 'Category.first.projects.count', -1 do
            find("##{dom_id categories(:one)}").find("##{dom_id projects(:one)}").click_on 'Desasociar'
        end
        assert_selector '#uncategorized_big_card h3', text: projects(:one).title

        assert_difference 'Category.first.products.count', -1 do
            find("##{dom_id categories(:one)}").find("##{dom_id products(:one)}").click_on 'Desasociar'
        end
        assert_selector '#uncategorized_big_card h3', text: products(:one).title
    end
end
