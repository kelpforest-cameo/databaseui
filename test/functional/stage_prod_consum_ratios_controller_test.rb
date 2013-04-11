require 'test_helper'

class StageProdConsumRatiosControllerTest < ActionController::TestCase
  setup do
    @stage_prod_consum_ratio = stage_prod_consum_ratios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_prod_consum_ratios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_prod_consum_ratio" do
    assert_difference('StageProdConsumRatio.count') do
      post :create, stage_prod_consum_ratio: {  }
    end

    assert_redirected_to stage_prod_consum_ratio_path(assigns(:stage_prod_consum_ratio))
  end

  test "should show stage_prod_consum_ratio" do
    get :show, id: @stage_prod_consum_ratio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_prod_consum_ratio
    assert_response :success
  end

  test "should update stage_prod_consum_ratio" do
    put :update, id: @stage_prod_consum_ratio, stage_prod_consum_ratio: {  }
    assert_redirected_to stage_prod_consum_ratio_path(assigns(:stage_prod_consum_ratio))
  end

  test "should destroy stage_prod_consum_ratio" do
    assert_difference('StageProdConsumRatio.count', -1) do
      delete :destroy, id: @stage_prod_consum_ratio
    end

    assert_redirected_to stage_prod_consum_ratios_path
  end
end
