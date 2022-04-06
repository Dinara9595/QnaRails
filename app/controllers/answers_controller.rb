class AnswersController < ApplicationController
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
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to answer_path(id: @answer)
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_answers_path(@answer.question)
  end

  private

  def load_question
    @question = Question.find_by!(id: params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
