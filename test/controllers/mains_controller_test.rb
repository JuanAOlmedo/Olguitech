require 'test_helper'

class MainsControllerTest < ActionDispatch::IntegrationTest
    test 'should show main' do
        get '/'
        assert_response :success
    end
end
