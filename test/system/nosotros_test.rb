require "application_system_test_case"

class NosotrosTest < ApplicationSystemTestCase
  setup do
    @nosotro = nosotros(:one)
  end

  test "visiting the index" do
    visit nosotros_url
    assert_selector "h1", text: "Nosotros"
  end

  test "creating a Nosotro" do
    visit nosotros_url
    click_on "New Nosotro"

    click_on "Create Nosotro"

    assert_text "Nosotro was successfully created"
    click_on "Back"
  end

  test "updating a Nosotro" do
    visit nosotros_url
    click_on "Edit", match: :first

    click_on "Update Nosotro"

    assert_text "Nosotro was successfully updated"
    click_on "Back"
  end

  test "destroying a Nosotro" do
    visit nosotros_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Nosotro was successfully destroyed"
  end
end
