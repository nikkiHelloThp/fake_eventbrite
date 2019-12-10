require 'test_helper'

class SuperAdmin::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get super_admin_events_index_url
    assert_response :success
  end

  test "should get show" do
    get super_admin_events_show_url
    assert_response :success
  end

  test "should get new" do
    get super_admin_events_new_url
    assert_response :success
  end

  test "should get create" do
    get super_admin_events_create_url
    assert_response :success
  end

  test "should get edit" do
    get super_admin_events_edit_url
    assert_response :success
  end

  test "should get update" do
    get super_admin_events_update_url
    assert_response :success
  end

  test "should get destroy" do
    get super_admin_events_destroy_url
    assert_response :success
  end

end
