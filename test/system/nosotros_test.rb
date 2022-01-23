# frozen_string_literal: true

require 'application_system_test_case'

class NosotrosTest < ApplicationSystemTestCase
    test 'should get index' do
        visit root_url

        click_on 'Nosotros'

        assert_selector 'h1', text: '¿Quiénes Somos?'
    end
end
