require 'test_helper'

class TrophicInteractionsControllerTest < ActionController::TestCase
  setup do
    @trophic_interaction = trophic_interactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trophic_interactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trophic_interaction" do
    assert_difference('TrophicInteraction.count') do
      post :create, trophic_interaction: {  }
    end

    assert_redirected_to trophic_interaction_path(assigns(:trophic_interaction))
  end

  test "should show trophic_interaction" do
    get :show, id: @trophic_interaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trophic_interaction
    assert_response :success
  end

  test "should update trophic_interaction" do
    put :update, id: @trophic_interaction, trophic_interaction: {  }
    assert_redirected_to trophic_interaction_path(assigns(:trophic_interaction))
  end

  test "should destroy trophic_interaction" do
    assert_difference('TrophicInteraction.count', -1) do
      delete :destroy, id: @trophic_interaction
    end

    assert_redirected_to trophic_interactions_path
  end
end
