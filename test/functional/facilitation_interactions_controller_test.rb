require 'test_helper'

class FacilitationInteractionsControllerTest < ActionController::TestCase
  setup do
    @facilitation_interaction = facilitation_interactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facilitation_interactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facilitation_interaction" do
    assert_difference('FacilitationInteraction.count') do
      post :create, facilitation_interaction: {  }
    end

    assert_redirected_to facilitation_interaction_path(assigns(:facilitation_interaction))
  end

  test "should show facilitation_interaction" do
    get :show, id: @facilitation_interaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facilitation_interaction
    assert_response :success
  end

  test "should update facilitation_interaction" do
    put :update, id: @facilitation_interaction, facilitation_interaction: {  }
    assert_redirected_to facilitation_interaction_path(assigns(:facilitation_interaction))
  end

  test "should destroy facilitation_interaction" do
    assert_difference('FacilitationInteraction.count', -1) do
      delete :destroy, id: @facilitation_interaction
    end

    assert_redirected_to facilitation_interactions_path
  end
end
