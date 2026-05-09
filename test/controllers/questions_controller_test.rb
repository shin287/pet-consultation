require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
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
end
