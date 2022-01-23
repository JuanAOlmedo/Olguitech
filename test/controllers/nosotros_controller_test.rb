# frozen_string_literal: true

require 'test_helper'

class NosotrosControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
        get nosotros_url
        assert_response :success
    end
end
