require "application_system_test_case"

class ResortsTest < ApplicationSystemTestCase
  setup do
    @resort = resorts(:one)
  end

  test "visiting the index" do
    visit resorts_url
    assert_selector "h1", text: "Resorts"
  end

  test "creating a Resort" do
    visit resorts_url
    click_on "New Resort"

    fill_in "Next5 snowfall", with: @resort.next5_snowfall
    fill_in "Next snowfall", with: @resort.next_snowfall
    fill_in "Recent snowfall", with: @resort.recent_snowfall
    fill_in "Recent time", with: @resort.recent_time
    fill_in "Resort name", with: @resort.resort_name
    fill_in "Resort url", with: @resort.resort_url
    fill_in "State", with: @resort.state_id
    click_on "Create Resort"

    assert_text "Resort was successfully created"
    click_on "Back"
  end

  test "updating a Resort" do
    visit resorts_url
    click_on "Edit", match: :first

    fill_in "Next5 snowfall", with: @resort.next5_snowfall
    fill_in "Next snowfall", with: @resort.next_snowfall
    fill_in "Recent snowfall", with: @resort.recent_snowfall
    fill_in "Recent time", with: @resort.recent_time
    fill_in "Resort name", with: @resort.resort_name
    fill_in "Resort url", with: @resort.resort_url
    fill_in "State", with: @resort.state_id
    click_on "Update Resort"

    assert_text "Resort was successfully updated"
    click_on "Back"
  end

  test "destroying a Resort" do
    visit resorts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Resort was successfully destroyed"
  end
end
