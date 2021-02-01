require 'test_helper'

class MainsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @main = mains(:one)
  end

  test "should get index" do
    get mains_url
    assert_response :success
  end

  test "should get new" do
    get new_main_url
    assert_response :success
  end

  test "should create main" do
    assert_difference('Main.count') do
      post mains_url, params: { main: {  } }
    end

    assert_redirected_to main_url(Main.last)
  end

  test "should show main" do
    get main_url(@main)
    assert_response :success
  end

  test "should get edit" do
    get edit_main_url(@main)
    assert_response :success
  end

  test "should update main" do
    patch main_url(@main), params: { main: {  } }
    assert_redirected_to main_url(@main)
  end

  test "should destroy main" do
    assert_difference('Main.count', -1) do
      delete main_url(@main)
    end

    assert_redirected_to mains_url
  end
end
