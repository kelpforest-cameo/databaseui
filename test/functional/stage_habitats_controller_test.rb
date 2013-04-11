require 'test_helper'

class StageHabitatsControllerTest < ActionController::TestCase
  setup do
    @stage_habitat = stage_habitats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_habitats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_habitat" do
    assert_difference('StageHabitat.count') do
      post :create, stage_habitat: { cite_id: @stage_habitat.cite_id, comment: @stage_habitat.comment, datum: @stage_habitat.datum, habitat: @stage_habitat.habitat, stage_id: @stage_habitat.stage_id, user_id: @stage_habitat.user_id }
    end

    assert_redirected_to stage_habitat_path(assigns(:stage_habitat))
  end

  test "should show stage_habitat" do
    get :show, id: @stage_habitat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_habitat
    assert_response :success
  end

  test "should update stage_habitat" do
    put :update, id: @stage_habitat, stage_habitat: { cite_id: @stage_habitat.cite_id, comment: @stage_habitat.comment, datum: @stage_habitat.datum, habitat: @stage_habitat.habitat, stage_id: @stage_habitat.stage_id, user_id: @stage_habitat.user_id }
    assert_redirected_to stage_habitat_path(assigns(:stage_habitat))
  end

  test "should destroy stage_habitat" do
    assert_difference('StageHabitat.count', -1) do
      delete :destroy, id: @stage_habitat
    end

    assert_redirected_to stage_habitats_path
  end
end
