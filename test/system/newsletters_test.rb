# frozen_string_literal: true

require 'application_system_test_case'

class NewslettersTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'visiting a newsletter' do
        visit '/newsletters/1'
        assert_selector 'h1', text: newsletters(:one).title
    end

    test 'should create newsletter' do
        sign_in admins(:one)

        visit '/newsletters/new'

        fill_in 'Título', with: 'A Title'
        fill_in 'Asunto', with: 'Subject'

        assert_difference('Newsletter.count', 1) do
            click_on 'Crear'
        end
    end
end
