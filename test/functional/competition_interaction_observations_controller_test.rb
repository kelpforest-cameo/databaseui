require 'test_helper'

class CompetitionInteractionObservationsControllerTest < ActionController::TestCase
  setup do
    @competition_interaction_observation = competition_interaction_observations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:competition_interaction_observations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create competition_interaction_observation" do
    assert_difference('CompetitionInteractionObservation.count') do
      post :create, competition_interaction_observation: {  }
    end

    assert_redirected_to competition_interaction_observation_path(assigns(:competition_interaction_observation))
  end

  test "should show competition_interaction_observation" do
    get :show, id: @competition_interaction_observation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @competition_interaction_observation
    assert_response :success
  end

  test "should update competition_interaction_observation" do
    put :update, id: @competition_interaction_observation, competition_interaction_observation: {  }
    assert_redirected_to competition_interaction_observation_path(assigns(:competition_interaction_observation))
  end

  test "should destroy competition_interaction_observation" do
    assert_difference('CompetitionInteractionObservation.count', -1) do
      delete :destroy, id: @competition_interaction_observation
    end

    assert_redirected_to competition_interaction_observations_path
  end
end
