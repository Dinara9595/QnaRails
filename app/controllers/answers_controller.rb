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
    @answer = Answer.new(answer_params.merge(question: @question))

    if @answer.save
      redirect_to question_path(@question)
    else
      render :'questions/show'
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
    load_answer_destroy(@answer)

    if @deleted_answer
      @deleted_answer.destroy
      redirect_to question_path(@answer.question)
    else
      redirect_to questions_path(@answer.question), notice: 'Вы не можете удалить чужой ответ!'
    end
  end

  private

  def load_question
    @question = Question.find_by!(id: params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_answer_destroy(answer)
    current_user_question = current_user.questions.find_by(id: @answer.question.id)
    @deleted_answer = current_user_question.answers.find_by(id: answer.id) if current_user_question
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
