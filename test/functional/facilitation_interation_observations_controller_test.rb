require 'test_helper'

class FacilitationInterationObservationsControllerTest < ActionController::TestCase
  setup do
    @facilitation_interation_observation = facilitation_interation_observations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facilitation_interation_observations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facilitation_interation_observation" do
    assert_difference('FacilitationInterationObservation.count') do
      post :create, facilitation_interation_observation: {  }
    end

    assert_redirected_to facilitation_interation_observation_path(assigns(:facilitation_interation_observation))
  end

  test "should show facilitation_interation_observation" do
    get :show, id: @facilitation_interation_observation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facilitation_interation_observation
    assert_response :success
  end

  test "should update facilitation_interation_observation" do
    put :update, id: @facilitation_interation_observation, facilitation_interation_observation: {  }
    assert_redirected_to facilitation_interation_observation_path(assigns(:facilitation_interation_observation))
  end

  test "should destroy facilitation_interation_observation" do
    assert_difference('FacilitationInterationObservation.count', -1) do
      delete :destroy, id: @facilitation_interation_observation
    end

    assert_redirected_to facilitation_interation_observations_path
  end
end
