require 'test_helper'

class ContactosControllerTest < ActionDispatch::IntegrationTest
    setup { @contacto = contactos(:one) }

    test 'should get index' do
        get '/contacto'
        assert_response :success

        get '/contactos'
        assert_response :success
    end

    test 'should get new' do
        get '/contacto/new'
        assert_response :success

        get '/contactos/new'
        assert_response :success
    end
end
