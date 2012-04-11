require 'test_helper'

class ParsableFilesControllerTest < ActionController::TestCase
  setup do
    @parsable_file = parsable_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parsable_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parsable_file" do
    assert_difference('ParsableFile.count') do
      post :create, parsable_file: @parsable_file.attributes
    end

    assert_redirected_to parsable_file_path(assigns(:parsable_file))
  end

  test "should show parsable_file" do
    get :show, id: @parsable_file.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parsable_file.to_param
    assert_response :success
  end

  test "should update parsable_file" do
    put :update, id: @parsable_file.to_param, parsable_file: @parsable_file.attributes
    assert_redirected_to parsable_file_path(assigns(:parsable_file))
  end

  test "should destroy parsable_file" do
    assert_difference('ParsableFile.count', -1) do
      delete :destroy, id: @parsable_file.to_param
    end

    assert_redirected_to parsable_files_path
  end
end
