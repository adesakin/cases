require 'test_helper'

class SlicesControllerTest < ActionController::TestCase
  setup do
    @slice = create(:slice)
    @user = create(:user, password: "secretkey", email: "sample@test.cases.com")
    sign_in @user
  end

  test "should respond to option" do
    post :option, :format => 'js', project_id: @slice.project.id
    assert_response :success
  end

  test "should get index" do
    get :index, project_id: @slice.project.id
    assert_response :success
    assert_not_nil assigns(:slices)
  end

  test "should get new" do
    skip "To be refecatored into a nested attribute form"
  end

  test "should create slice" do
    assert_difference('Slice.count') do
      post :create, project_id: @slice.project, slice: { estimate: @slice.estimate, order_priority: @slice.order_priority, priority: @slice.priority, release_id: @slice.release_id, workflow_state: @slice.workflow_state }
    end

    assert_redirected_to project_slice_path(@slice.project, assigns(:slice))
  end

  test "should show slice" do
    get :show, project_id: @slice.project, id: @slice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slice, project_id: @slice.project
    assert_response :success
  end

  test "should update slice" do
    patch :update, :project_id => @slice.project.id, id: @slice, slice: { estimate: @slice.estimate, order_priority: @slice.order_priority, priority: @slice.priority, release_id: @slice.release_id, workflow_state: @slice.workflow_state }
    assert_redirected_to project_slice_path(@slice.project, assigns(:slice))
  end

  test "should destroy slice" do
    assert_difference('Slice.count', -1) do
      delete :destroy, :project_id => @slice.project, id: @slice
    end

    assert_redirected_to project_slices_path
  end
end
