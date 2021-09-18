require 'test_helper'

class ContactosControllerTest < ActionDispatch::IntegrationTest
    setup { @contacto = contactos(:one) }

    test 'should get index' do
        get contactos_url
        assert_response :success
    end
end
