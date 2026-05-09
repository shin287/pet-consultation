require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sessions_new_url
    assert_response :success
  end

  test "guest login creates a general user session" do
    post guest_login_url

    guest = User.find_by(email: "guest@example.com")
    assert_equal "ゲストユーザー", guest.name
    assert_equal "general", guest.role
    assert_equal guest.id, session[:user_id]
    assert_redirected_to questions_url
  end
end
