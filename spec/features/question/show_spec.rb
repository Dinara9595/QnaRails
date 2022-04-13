require 'rails_helper'

feature 'User can view the question and its answers' do
  given(:user) { create(:user) }
  given(:question) { create(:question, :with_answers) }

  scenario 'Authenticated user can view the question and its answers' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content "#{question.answers.first.body}"
    expect(page).to have_content "#{question.answers.last.body}"
  end

  scenario 'Unauthenticated user can view the question and its answers' do
    visit question_path(question)

    expect(page).to have_content "#{question.answers.first.body}"
    expect(page).to have_content "#{question.answers.last.body}"
  end
end