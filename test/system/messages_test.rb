# frozen_string_literal: true

require 'application_system_test_case'

class MessagesTest < ApplicationSystemTestCase
    test 'should be able to contact when registered user' do
        visit '/es/contacto'

        fill_in 'message_content', with: 'Question'
        fill_in 'user_email', with: 'test1@test.com'

        sleep(1)

        assert_difference('User.count', 0) do
            assert_difference('Message.count', 1) do
                click_on 'Preguntar'
            end
        end

        assert_selector 'p', text: 'Gracias por tu mensaje. Nos pondremos en contacto pronto.'
    end

    test 'should be able to contact when new user' do
        visit root_url

        click_on 'Contacto'

        fill_in 'message_content', with: 'Question'
        fill_in 'user_email', with: 'test3@test.com'

        sleep(1)

        assert_difference('User.count', 1) do
            assert_difference('Message.count', 1) do
                click_on 'Preguntar'
            end
        end

        assert_selector 'p',
                        text: 'El mensaje se envió correctamente. Opcionalmente, puede dejarnos sus datos de contacto.'

        fill_in 'Nombre', with: 'A Name'
        click_on 'Confirmar'

        assert_selector 'p', text: 'Gracias por tu mensaje. Nos pondremos en contacto pronto.'
    end
end
