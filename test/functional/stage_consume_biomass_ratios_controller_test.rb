require 'test_helper'

class StageConsumeBiomassRatiosControllerTest < ActionController::TestCase
  setup do
    @stage_consume_biomass_ratio = stage_consume_biomass_ratios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_consume_biomass_ratios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_consume_biomass_ratio" do
    assert_difference('StageConsumeBiomassRatio.count') do
      post :create, stage_consume_biomass_ratio: { cite_id: @stage_consume_biomass_ratio.cite_id, comment: @stage_consume_biomass_ratio.comment, consume_biomass_ratio: @stage_consume_biomass_ratio.consume_biomass_ratio, datum: @stage_consume_biomass_ratio.datum, stage_id: @stage_consume_biomass_ratio.stage_id, user_id: @stage_consume_biomass_ratio.user_id }
    end

    assert_redirected_to stage_consume_biomass_ratio_path(assigns(:stage_consume_biomass_ratio))
  end

  test "should show stage_consume_biomass_ratio" do
    get :show, id: @stage_consume_biomass_ratio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_consume_biomass_ratio
    assert_response :success
  end

  test "should update stage_consume_biomass_ratio" do
    put :update, id: @stage_consume_biomass_ratio, stage_consume_biomass_ratio: { cite_id: @stage_consume_biomass_ratio.cite_id, comment: @stage_consume_biomass_ratio.comment, consume_biomass_ratio: @stage_consume_biomass_ratio.consume_biomass_ratio, datum: @stage_consume_biomass_ratio.datum, stage_id: @stage_consume_biomass_ratio.stage_id, user_id: @stage_consume_biomass_ratio.user_id }
    assert_redirected_to stage_consume_biomass_ratio_path(assigns(:stage_consume_biomass_ratio))
  end

  test "should destroy stage_consume_biomass_ratio" do
    assert_difference('StageConsumeBiomassRatio.count', -1) do
      delete :destroy, id: @stage_consume_biomass_ratio
    end

    assert_redirected_to stage_consume_biomass_ratios_path
  end
end
