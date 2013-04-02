require 'test_helper'

class NodeMaxAgesControllerTest < ActionController::TestCase
  setup do
    @node_max_age = node_max_ages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_max_ages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node_max_age" do
    assert_difference('NodeMaxAge.count') do
      post :create, node_max_age: {  }
    end

    assert_redirected_to node_max_age_path(assigns(:node_max_age))
  end

  test "should show node_max_age" do
    get :show, id: @node_max_age
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_max_age
    assert_response :success
  end

  test "should update node_max_age" do
    put :update, id: @node_max_age, node_max_age: {  }
    assert_redirected_to node_max_age_path(assigns(:node_max_age))
  end

  test "should destroy node_max_age" do
    assert_difference('NodeMaxAge.count', -1) do
      delete :destroy, id: @node_max_age
    end

    assert_redirected_to node_max_ages_path
  end
end
