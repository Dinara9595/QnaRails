require 'rails_helper'

feature 'User can choice best answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create_list(:answer, 2, user: user, question: question) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
      page.find_by_id("answer-#{answer[0].id}").click_on('Edit')
      check('Best')
      click_on('Save answer')
    end

    scenario 'can choice best answer' do
      expect(page).to have_content "BEST!"
    end

    scenario 'can choice another best answer', js: true do
      page.find_by_id("answer-#{answer[1].id}").click_on('Edit')
      check('Best')
      click_on('Save answer')

      expect(page.find_by_id("answer-#{answer[1].id}")).to have_content "BEST!"
    end
  end

  scenario 'Unauthenticated user tries to choice best answer' do
    visit question_path(question)
    expect(page).to have_no_link 'Edit'
  end
end

