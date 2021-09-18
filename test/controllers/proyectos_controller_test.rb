require 'test_helper'

class ProyectosControllerTest < ActionDispatch::IntegrationTest
    setup { @proyecto = proyectos(:one) }

    test 'should get index' do
        get proyectos_url
        assert_response :success
    end
end
