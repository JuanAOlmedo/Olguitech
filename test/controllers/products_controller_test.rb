require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
    setup { @product = products(:one) }

    test 'should get index' do
        get products_url
        assert_response :success
    end
end
