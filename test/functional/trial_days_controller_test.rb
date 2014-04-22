require 'test_helper'

class TrialDaysControllerTest < ActionController::TestCase
  setup do
    @trial_day = trial_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trial_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trial_day" do
    assert_difference('TrialDay.count') do
      post :create, trial_day: { days: @trial_day.days }
    end

    assert_redirected_to trial_day_path(assigns(:trial_day))
  end

  test "should show trial_day" do
    get :show, id: @trial_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trial_day
    assert_response :success
  end

  test "should update trial_day" do
    put :update, id: @trial_day, trial_day: { days: @trial_day.days }
    assert_redirected_to trial_day_path(assigns(:trial_day))
  end

  test "should destroy trial_day" do
    assert_difference('TrialDay.count', -1) do
      delete :destroy, id: @trial_day
    end

    assert_redirected_to trial_days_path
  end
end
