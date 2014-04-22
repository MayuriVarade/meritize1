require 'test_helper'

class VoteSettingsControllerTest < ActionController::TestCase
  setup do
    @vote_setting = vote_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vote_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote_setting" do
    assert_difference('VoteSetting.count') do
      post :create, vote_setting: { award_frequency_type: @vote_setting.award_frequency_type, award_program_name: @vote_setting.award_program_name, end_cycle: @vote_setting.end_cycle, intro_text: @vote_setting.intro_text, start_cycle: @vote_setting.start_cycle }
    end

    assert_redirected_to vote_setting_path(assigns(:vote_setting))
  end

  test "should show vote_setting" do
    get :show, id: @vote_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vote_setting
    assert_response :success
  end

  test "should update vote_setting" do
    put :update, id: @vote_setting, vote_setting: { award_frequency_type: @vote_setting.award_frequency_type, award_program_name: @vote_setting.award_program_name, end_cycle: @vote_setting.end_cycle, intro_text: @vote_setting.intro_text, start_cycle: @vote_setting.start_cycle }
    assert_redirected_to vote_setting_path(assigns(:vote_setting))
  end

  test "should destroy vote_setting" do
    assert_difference('VoteSetting.count', -1) do
      delete :destroy, id: @vote_setting
    end

    assert_redirected_to vote_settings_path
  end
end
