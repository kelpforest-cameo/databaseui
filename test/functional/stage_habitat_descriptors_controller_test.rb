require 'test_helper'

class StageHabitatDescriptorsControllerTest < ActionController::TestCase
  setup do
    @stage_habitat_descriptor = stage_habitat_descriptors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stage_habitat_descriptors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage_habitat_descriptor" do
    assert_difference('StageHabitatDescriptor.count') do
      post :create, stage_habitat_descriptor: { descriptor: @stage_habitat_descriptor.descriptor }
    end

    assert_redirected_to stage_habitat_descriptor_path(assigns(:stage_habitat_descriptor))
  end

  test "should show stage_habitat_descriptor" do
    get :show, id: @stage_habitat_descriptor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stage_habitat_descriptor
    assert_response :success
  end

  test "should update stage_habitat_descriptor" do
    put :update, id: @stage_habitat_descriptor, stage_habitat_descriptor: { descriptor: @stage_habitat_descriptor.descriptor }
    assert_redirected_to stage_habitat_descriptor_path(assigns(:stage_habitat_descriptor))
  end

  test "should destroy stage_habitat_descriptor" do
    assert_difference('StageHabitatDescriptor.count', -1) do
      delete :destroy, id: @stage_habitat_descriptor
    end

    assert_redirected_to stage_habitat_descriptors_path
  end
end
