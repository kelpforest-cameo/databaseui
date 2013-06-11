require 'test_helper'

class StageFecunditiesControllerTest < ActionController::TestCase
  setup do
    @stage_fecundity = stage_fecundities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_fecundities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_fecundity" do
    assert_difference('StageFecundity.count') do
      post :create, stage_fecundity: {  }
    end

    assert_redirected_to stage_fecundity_path(assigns(:stage_fecundity))
  end

  test "should show stage_fecundity" do
    get :show, id: @stage_fecundity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_fecundity
    assert_response :success
  end

  test "should update stage_fecundity" do
    put :update, id: @stage_fecundity, stage_fecundity: {  }
    assert_redirected_to stage_fecundity_path(assigns(:stage_fecundity))
  end

  test "should destroy stage_fecundity" do
    assert_difference('StageFecundity.count', -1) do
      delete :destroy, id: @stage_fecundity
    end

    assert_redirected_to stage_fecundities_path
  end
end
