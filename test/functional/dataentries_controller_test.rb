require 'test_helper'

class DataentriesControllerTest < ActionController::TestCase
  setup do
    @dataentry = dataentries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataentries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataentry" do
    assert_difference('Dataentry.count') do
      post :create, dataentry: {  }
    end

    assert_redirected_to dataentry_path(assigns(:dataentry))
  end

  test "should show dataentry" do
    get :show, id: @dataentry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataentry
    assert_response :success
  end

  test "should update dataentry" do
    put :update, id: @dataentry, dataentry: {  }
    assert_redirected_to dataentry_path(assigns(:dataentry))
  end

  test "should destroy dataentry" do
    assert_difference('Dataentry.count', -1) do
      delete :destroy, id: @dataentry
    end

    assert_redirected_to dataentries_path
  end
end
