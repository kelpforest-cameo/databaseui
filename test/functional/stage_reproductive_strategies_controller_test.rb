require 'test_helper'

class StageReproductiveStrategiesControllerTest < ActionController::TestCase
  setup do
    @stage_reproductive_strategy = stage_reproductive_strategies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_reproductive_strategies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_reproductive_strategy" do
    assert_difference('StageReproductiveStrategy.count') do
      post :create, stage_reproductive_strategy: { cite_id: @stage_reproductive_strategy.cite_id, comment: @stage_reproductive_strategy.comment, datum: @stage_reproductive_strategy.datum, reproductive_strategy: @stage_reproductive_strategy.reproductive_strategy, stage_id: @stage_reproductive_strategy.stage_id, user_id: @stage_reproductive_strategy.user_id }
    end

    assert_redirected_to stage_reproductive_strategy_path(assigns(:stage_reproductive_strategy))
  end

  test "should show stage_reproductive_strategy" do
    get :show, id: @stage_reproductive_strategy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_reproductive_strategy
    assert_response :success
  end

  test "should update stage_reproductive_strategy" do
    put :update, id: @stage_reproductive_strategy, stage_reproductive_strategy: { cite_id: @stage_reproductive_strategy.cite_id, comment: @stage_reproductive_strategy.comment, datum: @stage_reproductive_strategy.datum, reproductive_strategy: @stage_reproductive_strategy.reproductive_strategy, stage_id: @stage_reproductive_strategy.stage_id, user_id: @stage_reproductive_strategy.user_id }
    assert_redirected_to stage_reproductive_strategy_path(assigns(:stage_reproductive_strategy))
  end

  test "should destroy stage_reproductive_strategy" do
    assert_difference('StageReproductiveStrategy.count', -1) do
      delete :destroy, id: @stage_reproductive_strategy
    end

    assert_redirected_to stage_reproductive_strategies_path
  end
end
