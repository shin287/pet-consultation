class AnswersController < ApplicationController
  before_action :require_expert
  def create
    @question = Question.find(params[:question_id])

    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to question_path(@question)
    else
      render "questions/show", status: :unprocessable_entity
    end
  end

  private

  def require_expert
    unless current_user&.expert?
      redirect_to questions_path
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
