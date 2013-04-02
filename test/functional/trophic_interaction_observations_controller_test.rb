require 'test_helper'

class TrophicInteractionObservationsControllerTest < ActionController::TestCase
  setup do
    @trophic_interaction_observation = trophic_interaction_observations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trophic_interaction_observations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trophic_interaction_observation" do
    assert_difference('TrophicInteractionObservation.count') do
      post :create, trophic_interaction_observation: { cite_id: @trophic_interaction_observation.cite_id, comment: @trophic_interaction_observation.comment, datum: @trophic_interaction_observation.datum, lethality: @trophic_interaction_observation.lethality, location_id: @trophic_interaction_observation.location_id, observation_type: @trophic_interaction_observation.observation_type, percentage_consumed: @trophic_interaction_observation.percentage_consumed, percentage_diet: @trophic_interaction_observation.percentage_diet, percentage_diet_by: @trophic_interaction_observation.percentage_diet_by, prefernce: @trophic_interaction_observation.prefernce, structures_consumed: @trophic_interaction_observation.structures_consumed, trophic_interaction_id: @trophic_interaction_observation.trophic_interaction_id, user_id: @trophic_interaction_observation.user_id }
    end

    assert_redirected_to trophic_interaction_observation_path(assigns(:trophic_interaction_observation))
  end

  test "should show trophic_interaction_observation" do
    get :show, id: @trophic_interaction_observation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trophic_interaction_observation
    assert_response :success
  end

  test "should update trophic_interaction_observation" do
    put :update, id: @trophic_interaction_observation, trophic_interaction_observation: { cite_id: @trophic_interaction_observation.cite_id, comment: @trophic_interaction_observation.comment, datum: @trophic_interaction_observation.datum, lethality: @trophic_interaction_observation.lethality, location_id: @trophic_interaction_observation.location_id, observation_type: @trophic_interaction_observation.observation_type, percentage_consumed: @trophic_interaction_observation.percentage_consumed, percentage_diet: @trophic_interaction_observation.percentage_diet, percentage_diet_by: @trophic_interaction_observation.percentage_diet_by, prefernce: @trophic_interaction_observation.prefernce, structures_consumed: @trophic_interaction_observation.structures_consumed, trophic_interaction_id: @trophic_interaction_observation.trophic_interaction_id, user_id: @trophic_interaction_observation.user_id }
    assert_redirected_to trophic_interaction_observation_path(assigns(:trophic_interaction_observation))
  end

  test "should destroy trophic_interaction_observation" do
    assert_difference('TrophicInteractionObservation.count', -1) do
      delete :destroy, id: @trophic_interaction_observation
    end

    assert_redirected_to trophic_interaction_observations_path
  end
end
