require 'test_helper'

class BaseControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get sessions" do
    get :sessions
    assert_response :success
  end

end
