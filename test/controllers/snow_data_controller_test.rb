require 'test_helper'

class SnowDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @snow_datum = snow_data(:one)
  end

  test "should get index" do
    get snow_data_url
    assert_response :success
  end

  test "should get new" do
    get new_snow_datum_url
    assert_response :success
  end

  test "should create snow_datum" do
    assert_difference('SnowDatum.count') do
      post snow_data_url, params: { snow_datum: { next5_snowfall: @snow_datum.next5_snowfall, next_snowfall: @snow_datum.next_snowfall, recent_snowfall: @snow_datum.recent_snowfall, recent_time: @snow_datum.recent_time, resort_id: @snow_datum.resort_id } }
    end

    assert_redirected_to snow_datum_url(SnowDatum.last)
  end

  test "should show snow_datum" do
    get snow_datum_url(@snow_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_snow_datum_url(@snow_datum)
    assert_response :success
  end

  test "should update snow_datum" do
    patch snow_datum_url(@snow_datum), params: { snow_datum: { next5_snowfall: @snow_datum.next5_snowfall, next_snowfall: @snow_datum.next_snowfall, recent_snowfall: @snow_datum.recent_snowfall, recent_time: @snow_datum.recent_time, resort_id: @snow_datum.resort_id } }
    assert_redirected_to snow_datum_url(@snow_datum)
  end

  test "should destroy snow_datum" do
    assert_difference('SnowDatum.count', -1) do
      delete snow_datum_url(@snow_datum)
    end

    assert_redirected_to snow_data_url
  end
end
