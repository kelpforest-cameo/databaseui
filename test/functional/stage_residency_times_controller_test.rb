require 'test_helper'

class StageResidencyTimesControllerTest < ActionController::TestCase
  setup do
    @stage_residency_time = stage_residency_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_residency_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_residency_time" do
    assert_difference('StageResidencyTime.count') do
      post :create, stage_residency_time: {  }
    end

    assert_redirected_to stage_residency_time_path(assigns(:stage_residency_time))
  end

  test "should show stage_residency_time" do
    get :show, id: @stage_residency_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_residency_time
    assert_response :success
  end

  test "should update stage_residency_time" do
    put :update, id: @stage_residency_time, stage_residency_time: {  }
    assert_redirected_to stage_residency_time_path(assigns(:stage_residency_time))
  end

  test "should destroy stage_residency_time" do
    assert_difference('StageResidencyTime.count', -1) do
      delete :destroy, id: @stage_residency_time
    end

    assert_redirected_to stage_residency_times_path
  end
end
