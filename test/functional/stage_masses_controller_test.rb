require 'test_helper'

class StageMassesControllerTest < ActionController::TestCase
  setup do
    @stage_mass = stage_masses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_masses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_mass" do
    assert_difference('StageMass.count') do
      post :create, stage_mass: {  }
    end

    assert_redirected_to stage_mass_path(assigns(:stage_mass))
  end

  test "should show stage_mass" do
    get :show, id: @stage_mass
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_mass
    assert_response :success
  end

  test "should update stage_mass" do
    put :update, id: @stage_mass, stage_mass: {  }
    assert_redirected_to stage_mass_path(assigns(:stage_mass))
  end

  test "should destroy stage_mass" do
    assert_difference('StageMass.count', -1) do
      delete :destroy, id: @stage_mass
    end

    assert_redirected_to stage_masses_path
  end
end
