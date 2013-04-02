require 'test_helper'

class StageLengthFecunditiesControllerTest < ActionController::TestCase
  setup do
    @stage_length_fecundity = stage_length_fecundities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_length_fecundities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_length_fecundity" do
    assert_difference('StageLengthFecundity.count') do
      post :create, stage_length_fecundity: { a: @stage_length_fecundity.a, b: @stage_length_fecundity.b, cite_id: @stage_length_fecundity.cite_id, comment: @stage_length_fecundity.comment, datum: @stage_length_fecundity.datum, length_fecundity: @stage_length_fecundity.length_fecundity, stage_id: @stage_length_fecundity.stage_id, user_id: @stage_length_fecundity.user_id }
    end

    assert_redirected_to stage_length_fecundity_path(assigns(:stage_length_fecundity))
  end

  test "should show stage_length_fecundity" do
    get :show, id: @stage_length_fecundity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_length_fecundity
    assert_response :success
  end

  test "should update stage_length_fecundity" do
    put :update, id: @stage_length_fecundity, stage_length_fecundity: { a: @stage_length_fecundity.a, b: @stage_length_fecundity.b, cite_id: @stage_length_fecundity.cite_id, comment: @stage_length_fecundity.comment, datum: @stage_length_fecundity.datum, length_fecundity: @stage_length_fecundity.length_fecundity, stage_id: @stage_length_fecundity.stage_id, user_id: @stage_length_fecundity.user_id }
    assert_redirected_to stage_length_fecundity_path(assigns(:stage_length_fecundity))
  end

  test "should destroy stage_length_fecundity" do
    assert_difference('StageLengthFecundity.count', -1) do
      delete :destroy, id: @stage_length_fecundity
    end

    assert_redirected_to stage_length_fecundities_path
  end
end
