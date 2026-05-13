require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "一般ユーザー",
      email: "question-owner@example.com",
      password: "password",
      password_confirmation: "password"
    )

    @question = Question.create!(
      title: "変更前タイトル",
      body: "変更前本文",
      animal_type: "犬",
      consultation_type: "ごはん",
      animal_other: nil,
      user: @user
    )
  end

  test "should get index" do
    get questions_url
    assert_response :success
  end

  test "should get show" do
    get question_url(questions(:one))
    assert_response :success
  end

  test "redirects guest from new" do
    get new_question_url
    assert_redirected_to login_url
  end

  test "redirects guest from edit" do
    get edit_question_url(questions(:one))
    assert_redirected_to questions_url
  end

  test "does not update category fields" do
    post login_url, params: { email: @user.email, password: "password" }

    patch question_url(@question), params: {
      question: {
        title: "変更後タイトル",
        body: "変更後本文",
        animal_type: "猫",
        consultation_type: "病気・体調",
        animal_other: "うさぎ"
      }
    }

    @question.reload
    assert_equal "変更後タイトル", @question.title
    assert_equal "変更後本文", @question.body
    assert_equal "犬", @question.animal_type
    assert_equal "ごはん", @question.consultation_type
    assert_nil @question.animal_other
  end
end
