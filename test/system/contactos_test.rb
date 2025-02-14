# frozen_string_literal: true

require 'application_system_test_case'

class ContactosTest < ApplicationSystemTestCase
    test 'should be able to contact when registered user' do
        visit '/es/contactos'

        fill_in 'contacto_message', with: 'Question'
        fill_in 'user_email', with: 'test1@test.com'

        assert_difference('User.count', 0) do
            assert_difference('Contacto.count', 1) do
                click_on 'Hacer una pregunta!'
            end
        end

        assert_selector 'p', text: 'Un email ha sido enviado.'
    end

    test 'should be able to contact when new user' do
        visit root_url

        click_on 'Contacto'

        fill_in 'contacto_message', with: 'Question'
        fill_in 'user_email', with: 'test3@test.com'

        assert_difference('User.count', 1) do
            assert_difference('Contacto.count', 1) do
                click_on 'Hacer una pregunta!'
            end
        end

        assert_selector 'p',
                        text: 'Notamos que es la primera vez que te contactas con nosotros, por favor rellena tus datos'

        fill_in 'Nombre', with: 'A Name'
        click_on 'Enviar Mail'

        assert_selector 'p', text: 'Un email ha sido enviado.'
    end
end
