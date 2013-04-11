require 'test_helper'

class StageLifestylesControllerTest < ActionController::TestCase
  setup do
    @stage_lifestyle = stage_lifestyles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_lifestyles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_lifestyle" do
    assert_difference('StageLifestyle.count') do
      post :create, stage_lifestyle: { cite_id: @stage_lifestyle.cite_id, comment: @stage_lifestyle.comment, datum: @stage_lifestyle.datum, lifestyle: @stage_lifestyle.lifestyle, stage_id: @stage_lifestyle.stage_id, user_id: @stage_lifestyle.user_id }
    end

    assert_redirected_to stage_lifestyle_path(assigns(:stage_lifestyle))
  end

  test "should show stage_lifestyle" do
    get :show, id: @stage_lifestyle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_lifestyle
    assert_response :success
  end

  test "should update stage_lifestyle" do
    put :update, id: @stage_lifestyle, stage_lifestyle: { cite_id: @stage_lifestyle.cite_id, comment: @stage_lifestyle.comment, datum: @stage_lifestyle.datum, lifestyle: @stage_lifestyle.lifestyle, stage_id: @stage_lifestyle.stage_id, user_id: @stage_lifestyle.user_id }
    assert_redirected_to stage_lifestyle_path(assigns(:stage_lifestyle))
  end

  test "should destroy stage_lifestyle" do
    assert_difference('StageLifestyle.count', -1) do
      delete :destroy, id: @stage_lifestyle
    end

    assert_redirected_to stage_lifestyles_path
  end
end
