require 'test_helper'

class CompetitionInteractionsControllerTest < ActionController::TestCase
  setup do
    @competition_interaction = competition_interactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:competition_interactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create competition_interaction" do
    assert_difference('CompetitionInteraction.count') do
      post :create, competition_interaction: {  }
    end

    assert_redirected_to competition_interaction_path(assigns(:competition_interaction))
  end

  test "should show competition_interaction" do
    get :show, id: @competition_interaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @competition_interaction
    assert_response :success
  end

  test "should update competition_interaction" do
    put :update, id: @competition_interaction, competition_interaction: {  }
    assert_redirected_to competition_interaction_path(assigns(:competition_interaction))
  end

  test "should destroy competition_interaction" do
    assert_difference('CompetitionInteraction.count', -1) do
      delete :destroy, id: @competition_interaction
    end

    assert_redirected_to competition_interactions_path
  end
end
