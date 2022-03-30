class AnswersController < ApplicationController

  def new; end

  def create
    @question = Question.find_by!(id: params[:question_id])
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to answer_path(id: @answer)
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
