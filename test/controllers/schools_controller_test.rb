require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
  test "should get update_schools" do
    get :update_schools
    assert_response :success
  end

end
