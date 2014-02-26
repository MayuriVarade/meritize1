require 'test_helper'

class TrailDaysControllerTest < ActionController::TestCase
  setup do
    @trail_day = trail_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trail_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trail_day" do
    assert_difference('TrailDay.count') do
      post :create, trail_day: { days: @trail_day.days }
    end

    assert_redirected_to trail_day_path(assigns(:trail_day))
  end

  test "should show trail_day" do
    get :show, id: @trail_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trail_day
    assert_response :success
  end

  test "should update trail_day" do
    put :update, id: @trail_day, trail_day: { days: @trail_day.days }
    assert_redirected_to trail_day_path(assigns(:trail_day))
  end

  test "should destroy trail_day" do
    assert_difference('TrailDay.count', -1) do
      delete :destroy, id: @trail_day
    end

    assert_redirected_to trail_days_path
  end
end
