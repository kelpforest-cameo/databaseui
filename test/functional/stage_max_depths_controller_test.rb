require 'test_helper'

class StageMaxDepthsControllerTest < ActionController::TestCase
  setup do
    @stage_max_depth = stage_max_depths(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_max_depths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_max_depth" do
    assert_difference('StageMaxDepth.count') do
      post :create, stage_max_depth: {  }
    end

    assert_redirected_to stage_max_depth_path(assigns(:stage_max_depth))
  end

  test "should show stage_max_depth" do
    get :show, id: @stage_max_depth
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_max_depth
    assert_response :success
  end

  test "should update stage_max_depth" do
    put :update, id: @stage_max_depth, stage_max_depth: {  }
    assert_redirected_to stage_max_depth_path(assigns(:stage_max_depth))
  end

  test "should destroy stage_max_depth" do
    assert_difference('StageMaxDepth.count', -1) do
      delete :destroy, id: @stage_max_depth
    end

    assert_redirected_to stage_max_depths_path
  end
end
