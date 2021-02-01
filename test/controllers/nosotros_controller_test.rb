require 'test_helper'

class NosotrosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nosotro = nosotros(:one)
  end

  test "should get index" do
    get nosotros_url
    assert_response :success
  end

  test "should get new" do
    get new_nosotro_url
    assert_response :success
  end

  test "should create nosotro" do
    assert_difference('Nosotro.count') do
      post nosotros_url, params: { nosotro: {  } }
    end

    assert_redirected_to nosotro_url(Nosotro.last)
  end

  test "should show nosotro" do
    get nosotro_url(@nosotro)
    assert_response :success
  end

  test "should get edit" do
    get edit_nosotro_url(@nosotro)
    assert_response :success
  end

  test "should update nosotro" do
    patch nosotro_url(@nosotro), params: { nosotro: {  } }
    assert_redirected_to nosotro_url(@nosotro)
  end

  test "should destroy nosotro" do
    assert_difference('Nosotro.count', -1) do
      delete nosotro_url(@nosotro)
    end

    assert_redirected_to nosotros_url
  end
end
