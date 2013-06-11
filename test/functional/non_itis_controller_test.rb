require 'test_helper'

class NonItisControllerTest < ActionController::TestCase
  setup do
    @non_iti = non_itis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:non_itis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create non_iti" do
    assert_difference('NonIti.count') do
      post :create, non_iti: { info: @non_iti.info, latin_name: @non_iti.latin_name, parent_id: @non_iti.parent_id, parent_id_is_itis: @non_iti.parent_id_is_itis, taxonomy_level: @non_iti.taxonomy_level, user_id: @non_iti.user_id }
    end

    assert_redirected_to non_iti_path(assigns(:non_iti))
  end

  test "should show non_iti" do
    get :show, id: @non_iti
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @non_iti
    assert_response :success
  end

  test "should update non_iti" do
    put :update, id: @non_iti, non_iti: { info: @non_iti.info, latin_name: @non_iti.latin_name, parent_id: @non_iti.parent_id, parent_id_is_itis: @non_iti.parent_id_is_itis, taxonomy_level: @non_iti.taxonomy_level, user_id: @non_iti.user_id }
    assert_redirected_to non_iti_path(assigns(:non_iti))
  end

  test "should destroy non_iti" do
    assert_difference('NonIti.count', -1) do
      delete :destroy, id: @non_iti
    end

    assert_redirected_to non_itis_path
  end
end
