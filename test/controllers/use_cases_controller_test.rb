require 'test_helper'

class UseCasesControllerTest < ActionController::TestCase
  setup do
    @use_case = use_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:use_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create use_case" do
    assert_difference('UseCase.count') do
      post :create, use_case: { alternate_flow: @use_case.alternate_flow, description: @use_case.description, name: @use_case.name, open_issue: @use_case.open_issue, post_condition: @use_case.post_condition, pre_condition: @use_case.pre_condition, standard_flow: @use_case.standard_flow, state: @use_case.state }
    end

    assert_redirected_to use_case_path(assigns(:use_case))
  end

  test "should show use_case" do
    get :show, id: @use_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @use_case
    assert_response :success
  end

  test "should update use_case" do
    patch :update, id: @use_case, use_case: { alternate_flow: @use_case.alternate_flow, description: @use_case.description, name: @use_case.name, open_issue: @use_case.open_issue, post_condition: @use_case.post_condition, pre_condition: @use_case.pre_condition, standard_flow: @use_case.standard_flow, state: @use_case.state }
    assert_redirected_to use_case_path(assigns(:use_case))
  end

  test "should destroy use_case" do
    assert_difference('UseCase.count', -1) do
      delete :destroy, id: @use_case
    end

    assert_redirected_to use_cases_path
  end
end
