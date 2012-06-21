require 'test_helper'

class TaskRunSetsControllerTest < ActionController::TestCase
  setup do
    @task_run_set = task_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_set" do
    assert_difference('TaskRunSet.count') do
      post :create, task_set: @task_run_set.attributes
    end

    assert_redirected_to task_set_path(assigns(:task_set))
  end

  test "should show task_set" do
    get :show, id: @task_run_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_run_set
    assert_response :success
  end

  test "should update task_set" do
    put :update, id: @task_run_set, task_set: @task_run_set.attributes
    assert_redirected_to task_set_path(assigns(:task_set))
  end

  test "should destroy task_set" do
    assert_difference('TaskRunSet.count', -1) do
      delete :destroy, id: @task_run_set
    end

    assert_redirected_to task_sets_path
  end
end
