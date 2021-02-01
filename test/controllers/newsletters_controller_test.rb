require 'test_helper'

class NewslettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @newsletter = newsletters(:one)
  end

  test "should get index" do
    get newsletters_url
    assert_response :success
  end

  test "should get new" do
    get new_newsletter_url
    assert_response :success
  end

  test "should create newsletter" do
    assert_difference('Newsletter.count') do
      post newsletters_url, params: { newsletter: { content: @newsletter.content, subject: @newsletter.subject, title: @newsletter.title } }
    end

    assert_redirected_to newsletter_url(Newsletter.last)
  end

  test "should show newsletter" do
    get newsletter_url(@newsletter)
    assert_response :success
  end

  test "should get edit" do
    get edit_newsletter_url(@newsletter)
    assert_response :success
  end

  test "should update newsletter" do
    patch newsletter_url(@newsletter), params: { newsletter: { content: @newsletter.content, subject: @newsletter.subject, title: @newsletter.title } }
    assert_redirected_to newsletter_url(@newsletter)
  end

  test "should destroy newsletter" do
    assert_difference('Newsletter.count', -1) do
      delete newsletter_url(@newsletter)
    end

    assert_redirected_to newsletters_url
  end
end
