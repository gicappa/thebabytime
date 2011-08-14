require 'test_helper'

class NursingTimesControllerTest < ActionController::TestCase
  setup do
    @nursing_time = nursing_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nursing_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nursing_time" do
    assert_difference('NursingTime.count') do
      post :create, nursing_time: @nursing_time.attributes
    end

    assert_redirected_to nursing_time_path(assigns(:nursing_time))
  end

  test "should show nursing_time" do
    get :show, id: @nursing_time.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nursing_time.to_param
    assert_response :success
  end

  test "should update nursing_time" do
    put :update, id: @nursing_time.to_param, nursing_time: @nursing_time.attributes
    assert_redirected_to nursing_time_path(assigns(:nursing_time))
  end

  test "should destroy nursing_time" do
    assert_difference('NursingTime.count', -1) do
      delete :destroy, id: @nursing_time.to_param
    end

    assert_redirected_to nursing_times_path
  end
end
