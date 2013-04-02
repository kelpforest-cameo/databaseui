require 'test_helper'

class StageConsumerStrategiesControllerTest < ActionController::TestCase
  setup do
    @stage_consumer_strategy = stage_consumer_strategies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_consumer_strategies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_consumer_strategy" do
    assert_difference('StageConsumerStrategy.count') do
      post :create, stage_consumer_strategy: { cite_id: @stage_consumer_strategy.cite_id, comment: @stage_consumer_strategy.comment, consumer_strategy: @stage_consumer_strategy.consumer_strategy, datum: @stage_consumer_strategy.datum, stage_id: @stage_consumer_strategy.stage_id, user_id: @stage_consumer_strategy.user_id }
    end

    assert_redirected_to stage_consumer_strategy_path(assigns(:stage_consumer_strategy))
  end

  test "should show stage_consumer_strategy" do
    get :show, id: @stage_consumer_strategy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_consumer_strategy
    assert_response :success
  end

  test "should update stage_consumer_strategy" do
    put :update, id: @stage_consumer_strategy, stage_consumer_strategy: { cite_id: @stage_consumer_strategy.cite_id, comment: @stage_consumer_strategy.comment, consumer_strategy: @stage_consumer_strategy.consumer_strategy, datum: @stage_consumer_strategy.datum, stage_id: @stage_consumer_strategy.stage_id, user_id: @stage_consumer_strategy.user_id }
    assert_redirected_to stage_consumer_strategy_path(assigns(:stage_consumer_strategy))
  end

  test "should destroy stage_consumer_strategy" do
    assert_difference('StageConsumerStrategy.count', -1) do
      delete :destroy, id: @stage_consumer_strategy
    end

    assert_redirected_to stage_consumer_strategies_path
  end
end
