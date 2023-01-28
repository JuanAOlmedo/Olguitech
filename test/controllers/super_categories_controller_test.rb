require "test_helper"

class SuperCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @super_category = super_categories(:one)
  end

  test "should get index" do
    get super_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_super_category_url
    assert_response :success
  end

  test "should create super_category" do
    assert_difference("SuperCategory.count") do
      post super_categories_url, params: { super_category: {  } }
    end

    assert_redirected_to super_category_url(SuperCategory.last)
  end

  test "should show super_category" do
    get super_category_url(@super_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_super_category_url(@super_category)
    assert_response :success
  end

  test "should update super_category" do
    patch super_category_url(@super_category), params: { super_category: {  } }
    assert_redirected_to super_category_url(@super_category)
  end

  test "should destroy super_category" do
    assert_difference("SuperCategory.count", -1) do
      delete super_category_url(@super_category)
    end

    assert_redirected_to super_categories_url
  end
end
