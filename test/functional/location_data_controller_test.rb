require 'test_helper'

class LocationDataControllerTest < ActionController::TestCase
  setup do
    @location_datum = location_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:location_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location_datum" do
    assert_difference('LocationDatum.count') do
      post :create, location_datum: {  }
    end

    assert_redirected_to location_datum_path(assigns(:location_datum))
  end

  test "should show location_datum" do
    get :show, id: @location_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location_datum
    assert_response :success
  end

  test "should update location_datum" do
    put :update, id: @location_datum, location_datum: {  }
    assert_redirected_to location_datum_path(assigns(:location_datum))
  end

  test "should destroy location_datum" do
    assert_difference('LocationDatum.count', -1) do
      delete :destroy, id: @location_datum
    end

    assert_redirected_to location_data_path
  end
end
