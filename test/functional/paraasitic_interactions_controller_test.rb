require 'test_helper'

class ParaasiticInteractionsControllerTest < ActionController::TestCase
  setup do
    @paraasitic_interaction = paraasitic_interactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paraasitic_interactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paraasitic_interaction" do
    assert_difference('ParaasiticInteraction.count') do
      post :create, paraasitic_interaction: {  }
    end

    assert_redirected_to paraasitic_interaction_path(assigns(:paraasitic_interaction))
  end

  test "should show paraasitic_interaction" do
    get :show, id: @paraasitic_interaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paraasitic_interaction
    assert_response :success
  end

  test "should update paraasitic_interaction" do
    put :update, id: @paraasitic_interaction, paraasitic_interaction: {  }
    assert_redirected_to paraasitic_interaction_path(assigns(:paraasitic_interaction))
  end

  test "should destroy paraasitic_interaction" do
    assert_difference('ParaasiticInteraction.count', -1) do
      delete :destroy, id: @paraasitic_interaction
    end

    assert_redirected_to paraasitic_interactions_path
  end
end
