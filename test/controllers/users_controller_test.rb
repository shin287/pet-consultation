require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "一般ユーザー",
      email: "general@example.com",
      password: "password",
      password_confirmation: "password"
    )

    @other_user = User.create!(
      name: "別ユーザー",
      email: "other@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "redirects guest from user profile" do
    get user_url(@user)
    assert_redirected_to login_url
  end

  test "allows user to see own profile" do
    post login_url, params: { email: @user.email, password: "password" }
    get user_url(@user)
    assert_response :success
  end

  test "redirects user from another user's profile" do
    post login_url, params: { email: @user.email, password: "password" }
    get user_url(@other_user)
    assert_redirected_to root_url
  end

  test "allows admin to see another user's profile" do
    admin = User.create!(
      name: "管理者",
      email: "admin@example.com",
      password: "password",
      password_confirmation: "password",
      role: "admin"
    )

    post login_url, params: { email: admin.email, password: "password" }
    get user_url(@user)
    assert_response :success
  end
end
