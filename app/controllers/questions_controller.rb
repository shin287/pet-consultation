class QuestionsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :require_login, only: [:new, :create]
  before_action :require_general_user, only: [:new, :create]

  def index
    @questions = Question.all

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @questions = @questions.where(
        "title LIKE ? OR body LIKE ? OR animal_type LIKE ? OR consultation_type LIKE ?",
        keyword,keyword,keyword,keyword
      )
    end

    if params[:status] == "answered"
      @questions = @questions.joins(:answers).distinct
    elsif params[:status] == "unanswered"
      @questions = @questions.left_joins(:answers).where(answers: { id: nil })
    end

    if params[:sort] == "old"
      @questions = @questions.order(created_at: :asc)
    else
      @questions = @questions.order(created_at: :desc)
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id

    if @question.save
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @question.answers.any?
      update_params = params.require(:question).permit(:additional_info)
    else
      update_params = question_params
    end

    if @question.update(update_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def require_general_user
    if current_user&.expert?
      redirect_to questions_path
    end
  end

  def correct_user
    @question = Question.find(params[:id])
    unless @question.user == current_user
      redirect_to questions_path
    end
  end

  def require_login
    unless current_user
      redirect_to login_path
    end
  end

  def question_params
    params.require(:question).permit(
      :title, 
      :body, 
      :category, 
      :additional_info, 
      :animal_type, 
      :consultation_type, 
      :animal_other,
      :image
    )
  end
end
