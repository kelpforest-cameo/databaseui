require 'test_helper'

class StageBiomassChangesControllerTest < ActionController::TestCase
  setup do
    @stage_biomass_change = stage_biomass_changes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_biomass_changes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_biomass_change" do
    assert_difference('StageBiomassChange.count') do
      post :create, stage_biomass_change: {  }
    end

    assert_redirected_to stage_biomass_change_path(assigns(:stage_biomass_change))
  end

  test "should show stage_biomass_change" do
    get :show, id: @stage_biomass_change
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_biomass_change
    assert_response :success
  end

  test "should update stage_biomass_change" do
    put :update, id: @stage_biomass_change, stage_biomass_change: {  }
    assert_redirected_to stage_biomass_change_path(assigns(:stage_biomass_change))
  end

  test "should destroy stage_biomass_change" do
    assert_difference('StageBiomassChange.count', -1) do
      delete :destroy, id: @stage_biomass_change
    end

    assert_redirected_to stage_biomass_changes_path
  end
end
