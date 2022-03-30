class QuestionsController < ApplicationController

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def new; end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end