require "test_helper"

class AnswersControllerTest < ActionDispatch::IntegrationTest
  test "redirects guest from create" do
    post question_answers_url(questions(:one)), params: { answer: { body: "回答です" } }
    assert_redirected_to questions_url
  end
end
