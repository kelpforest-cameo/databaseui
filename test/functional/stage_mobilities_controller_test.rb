require 'test_helper'

class StageMobilitiesControllerTest < ActionController::TestCase
  setup do
    @stage_mobility = stage_mobilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_mobilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_mobility" do
    assert_difference('StageMobility.count') do
      post :create, stage_mobility: { cite_id: @stage_mobility.cite_id, comment: @stage_mobility.comment, datum: @stage_mobility.datum, mobility: @stage_mobility.mobility, stage_id: @stage_mobility.stage_id, user_id: @stage_mobility.user_id }
    end

    assert_redirected_to stage_mobility_path(assigns(:stage_mobility))
  end

  test "should show stage_mobility" do
    get :show, id: @stage_mobility
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_mobility
    assert_response :success
  end

  test "should update stage_mobility" do
    put :update, id: @stage_mobility, stage_mobility: { cite_id: @stage_mobility.cite_id, comment: @stage_mobility.comment, datum: @stage_mobility.datum, mobility: @stage_mobility.mobility, stage_id: @stage_mobility.stage_id, user_id: @stage_mobility.user_id }
    assert_redirected_to stage_mobility_path(assigns(:stage_mobility))
  end

  test "should destroy stage_mobility" do
    assert_difference('StageMobility.count', -1) do
      delete :destroy, id: @stage_mobility
    end

    assert_redirected_to stage_mobilities_path
  end
end
