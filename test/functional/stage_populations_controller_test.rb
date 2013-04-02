require 'test_helper'

class StagePopulationsControllerTest < ActionController::TestCase
  setup do
    @stage_population = stage_populations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_populations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_population" do
    assert_difference('StagePopulation.count') do
      post :create, stage_population: {  }
    end

    assert_redirected_to stage_population_path(assigns(:stage_population))
  end

  test "should show stage_population" do
    get :show, id: @stage_population
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_population
    assert_response :success
  end

  test "should update stage_population" do
    put :update, id: @stage_population, stage_population: {  }
    assert_redirected_to stage_population_path(assigns(:stage_population))
  end

  test "should destroy stage_population" do
    assert_difference('StagePopulation.count', -1) do
      delete :destroy, id: @stage_population
    end

    assert_redirected_to stage_populations_path
  end
end
