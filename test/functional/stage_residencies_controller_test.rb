require 'test_helper'

class StageResidenciesControllerTest < ActionController::TestCase
  setup do
    @stage_residency = stage_residencies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_residencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_residency" do
    assert_difference('StageResidency.count') do
      post :create, stage_residency: { cite_id: @stage_residency.cite_id, comment: @stage_residency.comment, datum: @stage_residency.datum, residency: @stage_residency.residency, stage_id: @stage_residency.stage_id, user_id: @stage_residency.user_id }
    end

    assert_redirected_to stage_residency_path(assigns(:stage_residency))
  end

  test "should show stage_residency" do
    get :show, id: @stage_residency
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_residency
    assert_response :success
  end

  test "should update stage_residency" do
    put :update, id: @stage_residency, stage_residency: { cite_id: @stage_residency.cite_id, comment: @stage_residency.comment, datum: @stage_residency.datum, residency: @stage_residency.residency, stage_id: @stage_residency.stage_id, user_id: @stage_residency.user_id }
    assert_redirected_to stage_residency_path(assigns(:stage_residency))
  end

  test "should destroy stage_residency" do
    assert_difference('StageResidency.count', -1) do
      delete :destroy, id: @stage_residency
    end

    assert_redirected_to stage_residencies_path
  end
end
