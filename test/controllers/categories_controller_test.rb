require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
    setup { @category = categories(:one) }

    test 'should get index' do
        get categories_url
        assert_response :success
    end

    test 'should show article' do
        get '/categories/1'
        assert_response :success
    end
end
