# frozen_string_literal: true

require 'test_helper'

class ContactosControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
        get '/contacto'
        assert_response :success

        get '/contactos'
        assert_response :success
    end
end
