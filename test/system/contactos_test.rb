# frozen_string_literal: true

require 'application_system_test_case'

class ContactosTest < ApplicationSystemTestCase
    test 'should be able to contact' do
        visit root_url

        click_on 'Contacto'

        fill_in 'Email', with: 'test10@test.com'
        fill_in 'Cómo podemos ayudarte?', with: 'Question'

        assert_difference('User.count', 1) do
            click_on 'Hacer una pregunta!'
        end

        assert_selector 'p',
                        text: 'Notamos que es la primera vez que te contactas con nosotros, por favor rellena tus datos'

        fill_in 'Nombre', with: 'A Name'
        click_on 'Enviar Mail'

        assert_selector 'p', text: 'Un email ha sido enviado.'
    end
end
