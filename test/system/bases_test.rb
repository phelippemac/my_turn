require "application_system_test_case"

class BasesTest < ApplicationSystemTestCase
  setup do
    @basis = bases(:one)
  end

  test "visiting the index" do
    visit bases_url
    assert_selector "h1", text: "Bases"
  end

  test "creating a Base" do
    visit bases_url
    click_on "New Base"

    fill_in "Code", with: @basis.code
    fill_in "Email", with: @basis.email
    fill_in "Level", with: @basis.level
    check "Use" if @basis.use
    click_on "Create Base"

    assert_text "Base was successfully created"
    click_on "Back"
  end

  test "updating a Base" do
    visit bases_url
    click_on "Edit", match: :first

    fill_in "Code", with: @basis.code
    fill_in "Email", with: @basis.email
    fill_in "Level", with: @basis.level
    check "Use" if @basis.use
    click_on "Update Base"

    assert_text "Base was successfully updated"
    click_on "Back"
  end

  test "destroying a Base" do
    visit bases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Base was successfully destroyed"
  end
end
