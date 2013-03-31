require 'test_helper'

class StageDurationsControllerTest < ActionController::TestCase
  setup do
    @stage_duration = stage_durations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_durations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_duration" do
    assert_difference('StageDuration.count') do
      post :create, stage_duration: {  }
    end

    assert_redirected_to stage_duration_path(assigns(:stage_duration))
  end

  test "should show stage_duration" do
    get :show, id: @stage_duration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_duration
    assert_response :success
  end

  test "should update stage_duration" do
    put :update, id: @stage_duration, stage_duration: {  }
    assert_redirected_to stage_duration_path(assigns(:stage_duration))
  end

  test "should destroy stage_duration" do
    assert_difference('StageDuration.count', -1) do
      delete :destroy, id: @stage_duration
    end

    assert_redirected_to stage_durations_path
  end
end
