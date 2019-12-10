require 'test_helper'

class SuperAdmin::SuperAdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get super_admin_super_admins_index_url
    assert_response :success
  end

end
