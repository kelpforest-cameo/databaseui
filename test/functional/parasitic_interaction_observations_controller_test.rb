require 'test_helper'

class ParasiticInteractionObservationsControllerTest < ActionController::TestCase
  setup do
    @parasitic_interaction_observation = parasitic_interaction_observations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parasitic_interaction_observations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parasitic_interaction_observation" do
    assert_difference('ParasiticInteractionObservation.count') do
      post :create, parasitic_interaction_observation: { cite_id: @parasitic_interaction_observation.cite_id, comment: @parasitic_interaction_observation.comment, datum: @parasitic_interaction_observation.datum, endo_ecto: @parasitic_interaction_observation.endo_ecto, intensity: @parasitic_interaction_observation.intensity, lethality: @parasitic_interaction_observation.lethality, location_id: @parasitic_interaction_observation.location_id, observation_type: @parasitic_interaction_observation.observation_type, parasite_type: @parasitic_interaction_observation.parasite_type, parasitic_interaction_id: @parasitic_interaction_observation.parasitic_interaction_id, prevalence: @parasitic_interaction_observation.prevalence, user_id: @parasitic_interaction_observation.user_id }
    end

    assert_redirected_to parasitic_interaction_observation_path(assigns(:parasitic_interaction_observation))
  end

  test "should show parasitic_interaction_observation" do
    get :show, id: @parasitic_interaction_observation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parasitic_interaction_observation
    assert_response :success
  end

  test "should update parasitic_interaction_observation" do
    put :update, id: @parasitic_interaction_observation, parasitic_interaction_observation: { cite_id: @parasitic_interaction_observation.cite_id, comment: @parasitic_interaction_observation.comment, datum: @parasitic_interaction_observation.datum, endo_ecto: @parasitic_interaction_observation.endo_ecto, intensity: @parasitic_interaction_observation.intensity, lethality: @parasitic_interaction_observation.lethality, location_id: @parasitic_interaction_observation.location_id, observation_type: @parasitic_interaction_observation.observation_type, parasite_type: @parasitic_interaction_observation.parasite_type, parasitic_interaction_id: @parasitic_interaction_observation.parasitic_interaction_id, prevalence: @parasitic_interaction_observation.prevalence, user_id: @parasitic_interaction_observation.user_id }
    assert_redirected_to parasitic_interaction_observation_path(assigns(:parasitic_interaction_observation))
  end

  test "should destroy parasitic_interaction_observation" do
    assert_difference('ParasiticInteractionObservation.count', -1) do
      delete :destroy, id: @parasitic_interaction_observation
    end

    assert_redirected_to parasitic_interaction_observations_path
  end
end
