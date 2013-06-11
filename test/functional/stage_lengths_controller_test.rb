require 'test_helper'

class StageLengthsControllerTest < ActionController::TestCase
  setup do
    @stage_length = stage_lengths(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_lengths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_length" do
    assert_difference('StageLength.count') do
      post :create, stage_length: {  }
    end

    assert_redirected_to stage_length_path(assigns(:stage_length))
  end

  test "should show stage_length" do
    get :show, id: @stage_length
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_length
    assert_response :success
  end

  test "should update stage_length" do
    put :update, id: @stage_length, stage_length: {  }
    assert_redirected_to stage_length_path(assigns(:stage_length))
  end

  test "should destroy stage_length" do
    assert_difference('StageLength.count', -1) do
      delete :destroy, id: @stage_length
    end

    assert_redirected_to stage_lengths_path
  end
end
