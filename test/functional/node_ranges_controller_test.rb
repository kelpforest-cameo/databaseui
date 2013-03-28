require 'test_helper'

class NodeRangesControllerTest < ActionController::TestCase
  setup do
    @node_range = node_ranges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_ranges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node_range" do
    assert_difference('NodeRange.count') do
      post :create, node_range: {  }
    end

    assert_redirected_to node_range_path(assigns(:node_range))
  end

  test "should show node_range" do
    get :show, id: @node_range
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_range
    assert_response :success
  end

  test "should update node_range" do
    put :update, id: @node_range, node_range: {  }
    assert_redirected_to node_range_path(assigns(:node_range))
  end

  test "should destroy node_range" do
    assert_difference('NodeRange.count', -1) do
      delete :destroy, id: @node_range
    end

    assert_redirected_to node_ranges_path
  end
end
