# frozen_string_literal: true

require 'application_system_test_case'

class MainsTest < ApplicationSystemTestCase
    test 'should get index' do
        visit root_url

        assert_selector 'h1',
                        text: 'Las últimas tendencias mundiales en Ingeniería Eléctrica, control, automatización y equipamiento industrial.'
    end

    test 'should subscribe' do
        visit root_url

        fill_in 'Email', with: 'test100@test.com'

        assert_difference('User.count', 1) do
            click_on 'Suscribirse'
        end

        assert_selector 'p', text: 'Muchas gracias por suscribirte a nuestra newsletter!'
    end
end
