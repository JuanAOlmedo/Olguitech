require "application_system_test_case"

class NewslettersTest < ApplicationSystemTestCase
  setup do
    @newsletter = newsletters(:one)
  end

  test "visiting the index" do
    visit newsletters_url
    assert_selector "h1", text: "Newsletters"
  end

  test "creating a Newsletter" do
    visit newsletters_url
    click_on "New Newsletter"

    fill_in "Content", with: @newsletter.content
    fill_in "Subject", with: @newsletter.subject
    fill_in "Title", with: @newsletter.title
    click_on "Create Newsletter"

    assert_text "Newsletter was successfully created"
    click_on "Back"
  end

  test "updating a Newsletter" do
    visit newsletters_url
    click_on "Edit", match: :first

    fill_in "Content", with: @newsletter.content
    fill_in "Subject", with: @newsletter.subject
    fill_in "Title", with: @newsletter.title
    click_on "Update Newsletter"

    assert_text "Newsletter was successfully updated"
    click_on "Back"
  end

  test "destroying a Newsletter" do
    visit newsletters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Newsletter was successfully destroyed"
  end
end
