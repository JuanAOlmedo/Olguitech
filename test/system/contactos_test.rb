require "application_system_test_case"

class ContactosTest < ApplicationSystemTestCase
  setup do
    @contacto = contactos(:one)
  end

  test "visiting the index" do
    visit contactos_url
    assert_selector "h1", text: "Contactos"
  end

  test "creating a Contacto" do
    visit contactos_url
    click_on "New Contacto"

    click_on "Create Contacto"

    assert_text "Contacto was successfully created"
    click_on "Back"
  end

  test "updating a Contacto" do
    visit contactos_url
    click_on "Edit", match: :first

    click_on "Update Contacto"

    assert_text "Contacto was successfully updated"
    click_on "Back"
  end

  test "destroying a Contacto" do
    visit contactos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contacto was successfully destroyed"
  end
end
