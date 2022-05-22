class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_answer, only: %i[show edit update destroy]
  before_action :load_question, only: %i[index create]

  def index
    @answers = @question.answers
  end

  def show; end

  def new
    @answer = Answer.new
  end

  def edit; end

  def create
    @answer = current_user.answers.create(answer_params.merge(question: @question))
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
  end

  private

  def load_question
    @question = Question.find_by!(id: params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :user_id)
  end
end
