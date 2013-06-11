require 'test_helper'

class ParasiticInteractionsControllerTest < ActionController::TestCase
  setup do
    @parasitic_interaction = parasitic_interactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parasitic_interactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parasitic_interaction" do
    assert_difference('ParasiticInteraction.count') do
      post :create, parasitic_interaction: {  }
    end

    assert_redirected_to parasitic_interaction_path(assigns(:parasitic_interaction))
  end

  test "should show parasitic_interaction" do
    get :show, id: @parasitic_interaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parasitic_interaction
    assert_response :success
  end

  test "should update parasitic_interaction" do
    put :update, id: @parasitic_interaction, parasitic_interaction: {  }
    assert_redirected_to parasitic_interaction_path(assigns(:parasitic_interaction))
  end

  test "should destroy parasitic_interaction" do
    assert_difference('ParasiticInteraction.count', -1) do
      delete :destroy, id: @parasitic_interaction
    end

    assert_redirected_to parasitic_interactions_path
  end
end
