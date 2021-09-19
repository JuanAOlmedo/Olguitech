require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
    setup { @article = articles(:one) }

    test 'should get index' do
        get articles_url
        assert_response :success
    end

    test 'should show article' do
        get '/articles/1'
        assert_response :success
    end
end
