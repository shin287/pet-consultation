require "test_helper"

class AnswersControllerTest < ActionDispatch::IntegrationTest
  test "redirects signed-out user from create" do
    post question_answers_url(questions(:one)), params: { answer: { body: "回答です" } }
    assert_redirected_to questions_url
  end

  test "allows guest user to create answer" do
    post guest_login_url

    assert_difference "Answer.count", 1 do
      post question_answers_url(questions(:one)), params: { answer: { body: "ゲストの回答です" } }
    end

    assert_redirected_to question_url(questions(:one))
    assert_equal "guest@example.com", Answer.last.user.email
  end

  test "redirects regular user from create" do
    user = User.create!(
      name: "一般ユーザー",
      email: "answer-general@example.com",
      password: "password",
      password_confirmation: "password"
    )
    post login_url, params: { email: user.email, password: "password" }

    assert_no_difference "Answer.count" do
      post question_answers_url(questions(:one)), params: { answer: { body: "一般ユーザーの回答です" } }
    end

    assert_redirected_to questions_url
  end
end
