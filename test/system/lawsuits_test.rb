require "application_system_test_case"

class LawsuitsTest < ApplicationSystemTestCase
  setup do
    @lawsuit = lawsuits(:one)
  end

  test "visiting the index" do
    visit lawsuits_url
    assert_selector "h1", text: "Lawsuits"
  end

  test "should create lawsuit" do
    visit lawsuits_url
    click_on "New lawsuit"

    fill_in "Alias", with: @lawsuit.alias
    fill_in "Category", with: @lawsuit.category
    fill_in "Created by", with: @lawsuit.created_by_id
    fill_in "Tenancies", with: @lawsuit.tenancies_id
    click_on "Create Lawsuit"

    assert_text "Lawsuit was successfully created"
    click_on "Back"
  end

  test "should update Lawsuit" do
    visit lawsuit_url(@lawsuit)
    click_on "Edit this lawsuit", match: :first

    fill_in "Alias", with: @lawsuit.alias
    fill_in "Category", with: @lawsuit.category
    fill_in "Created by", with: @lawsuit.created_by_id
    fill_in "Tenancies", with: @lawsuit.tenancies_id
    click_on "Update Lawsuit"

    assert_text "Lawsuit was successfully updated"
    click_on "Back"
  end

  test "should destroy Lawsuit" do
    visit lawsuit_url(@lawsuit)
    click_on "Destroy this lawsuit", match: :first

    assert_text "Lawsuit was successfully destroyed"
  end
end
