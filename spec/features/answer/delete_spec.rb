require 'rails_helper'

feature 'User can delete answer' do

  given(:user) { create(:user) }
  given!(:answer) { create(:answer) }

  scenario 'User can delete their answer' do
    sign_in(answer.user)
    visit questions_path
    page.find('table', text: 'QuestionBodyTest').click_link('Show')
    page.find('table', text: 'AnswerBodyTest').click_link('Delete')

    expect(page).to have_no_content 'MyText'
  end

  scenario "User can not delete someone else's answer" do
    sign_in(user)
    visit questions_path
    page.find('table', text: 'QuestionBodyTest').click_link('Show')

    expect(page.find('table', text: 'AnswerBodyTest')).to have_no_button 'Delete'
  end
end

