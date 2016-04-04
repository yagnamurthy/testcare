require 'test_helper'

class ExperiencesControllerTest < ActionController::TestCase
  test "should get update_experiences" do
    get :update_experiences
    assert_response :success
  end

end
