require 'test_helper'

class StageLengthWeightsControllerTest < ActionController::TestCase
  setup do
    @stage_length_weight = stage_length_weights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_length_weights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_length_weight" do
    assert_difference('StageLengthWeight.count') do
      post :create, stage_length_weight: { a: @stage_length_weight.a, b: @stage_length_weight.b, cite_id: @stage_length_weight.cite_id, comment: @stage_length_weight.comment, datum: @stage_length_weight.datum, length_weight: @stage_length_weight.length_weight, stage_id: @stage_length_weight.stage_id, user_id: @stage_length_weight.user_id }
    end

    assert_redirected_to stage_length_weight_path(assigns(:stage_length_weight))
  end

  test "should show stage_length_weight" do
    get :show, id: @stage_length_weight
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_length_weight
    assert_response :success
  end

  test "should update stage_length_weight" do
    put :update, id: @stage_length_weight, stage_length_weight: { a: @stage_length_weight.a, b: @stage_length_weight.b, cite_id: @stage_length_weight.cite_id, comment: @stage_length_weight.comment, datum: @stage_length_weight.datum, length_weight: @stage_length_weight.length_weight, stage_id: @stage_length_weight.stage_id, user_id: @stage_length_weight.user_id }
    assert_redirected_to stage_length_weight_path(assigns(:stage_length_weight))
  end

  test "should destroy stage_length_weight" do
    assert_difference('StageLengthWeight.count', -1) do
      delete :destroy, id: @stage_length_weight
    end

    assert_redirected_to stage_length_weights_path
  end
end
