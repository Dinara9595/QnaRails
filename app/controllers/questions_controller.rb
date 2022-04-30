class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    load_question_destroy(@question)
    if @deleted_question
      @deleted_question.destroy
      redirect_to questions_path
    else
      redirect_to questions_path, notice: 'Вы не можете удалить чужой вопрос!'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def load_question_destroy(question)
    @deleted_question = current_user.questions.find_by(id: question.id)
  end
end
