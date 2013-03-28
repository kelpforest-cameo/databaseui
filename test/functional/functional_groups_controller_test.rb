require 'test_helper'

class FunctionalGroupsControllerTest < ActionController::TestCase
  setup do
    @functional_group = functional_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:functional_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create functional_group" do
    assert_difference('FunctionalGroup.count') do
      post :create, functional_group: {  }
    end

    assert_redirected_to functional_group_path(assigns(:functional_group))
  end

  test "should show functional_group" do
    get :show, id: @functional_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @functional_group
    assert_response :success
  end

  test "should update functional_group" do
    put :update, id: @functional_group, functional_group: {  }
    assert_redirected_to functional_group_path(assigns(:functional_group))
  end

  test "should destroy functional_group" do
    assert_difference('FunctionalGroup.count', -1) do
      delete :destroy, id: @functional_group
    end

    assert_redirected_to functional_groups_path
  end
end
