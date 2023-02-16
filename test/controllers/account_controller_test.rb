require "test_helper"

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get account_signup_url
    assert_response :success
  end

  test "should get login" do
    get account_login_url
    assert_response :success
  end

  test "should get forget_password" do
    get account_forget_password_url
    assert_response :success
  end

  test "should get reset_password" do
    get account_reset_password_url
    assert_response :success
  end

  test "should get edit_profile" do
    get account_edit_profile_url
    assert_response :success
  end
end
