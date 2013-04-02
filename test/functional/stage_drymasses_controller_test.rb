require 'test_helper'

class StageDrymassesControllerTest < ActionController::TestCase
  setup do
    @stage_drymass = stage_drymasses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_drymasses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_drymass" do
    assert_difference('StageDrymass.count') do
      post :create, stage_drymass: {  }
    end

    assert_redirected_to stage_drymass_path(assigns(:stage_drymass))
  end

  test "should show stage_drymass" do
    get :show, id: @stage_drymass
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_drymass
    assert_response :success
  end

  test "should update stage_drymass" do
    put :update, id: @stage_drymass, stage_drymass: {  }
    assert_redirected_to stage_drymass_path(assigns(:stage_drymass))
  end

  test "should destroy stage_drymass" do
    assert_difference('StageDrymass.count', -1) do
      delete :destroy, id: @stage_drymass
    end

    assert_redirected_to stage_drymasses_path
  end
end
