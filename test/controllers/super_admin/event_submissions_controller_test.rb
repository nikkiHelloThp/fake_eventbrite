require 'test_helper'

class SuperAdmin::EventSubmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get super_admin_event_submissions_index_url
    assert_response :success
  end

  test "should get show" do
    get super_admin_event_submissions_show_url
    assert_response :success
  end

  test "should get edit" do
    get super_admin_event_submissions_edit_url
    assert_response :success
  end

  test "should get update" do
    get super_admin_event_submissions_update_url
    assert_response :success
  end

end
