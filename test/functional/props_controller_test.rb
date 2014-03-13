require 'test_helper'

class PropsControllerTest < ActionController::TestCase
  setup do
    @prop = props(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:props)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prop" do
    assert_difference('Prop.count') do
      post :create, prop: { assign_points: @prop.assign_points, body2: @prop.body2, body3: @prop.body3, body: @prop.body, email: @prop.email, enable: @prop.enable, end_cycle: @prop.end_cycle, end_point: @prop.end_point, intro: @prop.intro, name: @prop.name, reset_point: @prop.reset_point, start_cycle: @prop.start_cycle, start_point: @prop.start_point, step_point: @prop.step_point, subject2: @prop.subject2, subject3: @prop.subject3, subject: @prop.subject, user_id: @prop.user_id }
    end

    assert_redirected_to prop_path(assigns(:prop))
  end

  test "should show prop" do
    get :show, id: @prop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prop
    assert_response :success
  end

  test "should update prop" do
    put :update, id: @prop, prop: { assign_points: @prop.assign_points, body2: @prop.body2, body3: @prop.body3, body: @prop.body, email: @prop.email, enable: @prop.enable, end_cycle: @prop.end_cycle, end_point: @prop.end_point, intro: @prop.intro, name: @prop.name, reset_point: @prop.reset_point, start_cycle: @prop.start_cycle, start_point: @prop.start_point, step_point: @prop.step_point, subject2: @prop.subject2, subject3: @prop.subject3, subject: @prop.subject, user_id: @prop.user_id }
    assert_redirected_to prop_path(assigns(:prop))
  end

  test "should destroy prop" do
    assert_difference('Prop.count', -1) do
      delete :destroy, id: @prop
    end

    assert_redirected_to props_path
  end
end
