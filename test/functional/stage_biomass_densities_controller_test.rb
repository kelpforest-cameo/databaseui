require 'test_helper'

class StageBiomassDensitiesControllerTest < ActionController::TestCase
  setup do
    @stage_biomass_density = stage_biomass_densities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_biomass_densities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_biomass_density" do
    assert_difference('StageBiomassDensity.count') do
      post :create, stage_biomass_density: {  }
    end

    assert_redirected_to stage_biomass_density_path(assigns(:stage_biomass_density))
  end

  test "should show stage_biomass_density" do
    get :show, id: @stage_biomass_density
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_biomass_density
    assert_response :success
  end

  test "should update stage_biomass_density" do
    put :update, id: @stage_biomass_density, stage_biomass_density: {  }
    assert_redirected_to stage_biomass_density_path(assigns(:stage_biomass_density))
  end

  test "should destroy stage_biomass_density" do
    assert_difference('StageBiomassDensity.count', -1) do
      delete :destroy, id: @stage_biomass_density
    end

    assert_redirected_to stage_biomass_densities_path
  end
end
