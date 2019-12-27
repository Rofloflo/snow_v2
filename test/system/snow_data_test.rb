require "application_system_test_case"

class SnowDataTest < ApplicationSystemTestCase
  setup do
    @snow_datum = snow_data(:one)
  end

  test "visiting the index" do
    visit snow_data_url
    assert_selector "h1", text: "Snow Data"
  end

  test "creating a Snow datum" do
    visit snow_data_url
    click_on "New Snow Datum"

    fill_in "Next5 snowfall", with: @snow_datum.next5_snowfall
    fill_in "Next snowfall", with: @snow_datum.next_snowfall
    fill_in "Recent snowfall", with: @snow_datum.recent_snowfall
    fill_in "Recent time", with: @snow_datum.recent_time
    fill_in "Resort", with: @snow_datum.resort_id
    click_on "Create Snow datum"

    assert_text "Snow datum was successfully created"
    click_on "Back"
  end

  test "updating a Snow datum" do
    visit snow_data_url
    click_on "Edit", match: :first

    fill_in "Next5 snowfall", with: @snow_datum.next5_snowfall
    fill_in "Next snowfall", with: @snow_datum.next_snowfall
    fill_in "Recent snowfall", with: @snow_datum.recent_snowfall
    fill_in "Recent time", with: @snow_datum.recent_time
    fill_in "Resort", with: @snow_datum.resort_id
    click_on "Update Snow datum"

    assert_text "Snow datum was successfully updated"
    click_on "Back"
  end

  test "destroying a Snow datum" do
    visit snow_data_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Snow datum was successfully destroyed"
  end
end
