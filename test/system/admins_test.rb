# frozen_string_literal: true

require 'application_system_test_case'

class AdminsTest < ApplicationSystemTestCase
    teardown { sign_out :admin }

    test 'should sign in' do
    	visit '/admins/sign_in'

    	fill_in 'Email', with: admins(:one).email
    	fill_in 'Contraseña', with: 'superstrongpassword'
        click_button 'Acceder'

        assert_text 'Has accedido con éxito.'
    end

    test 'should lock account after five failed attempts' do
        visit '/admins/sign_in'

        5.times do
            fill_in 'Email', with: admins(:one).email
            fill_in 'Contraseña', with: 'wrongpassword'
            click_button 'Acceder'
        end

        assert_text 'Tu cuenta está bloqueada'
        assert admins(:one).reload.access_locked?

        # Verificar que tampoco puede entrar con la contraseña correcta
        fill_in 'Email', with: admins(:one).email
        fill_in 'Contraseña', with: 'superstrongpassword'
        click_button 'Acceder'

        assert_text 'Tu cuenta está bloqueada'

        admins(:one).unlock_access!
    end
end
