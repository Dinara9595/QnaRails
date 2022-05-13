require 'rails_helper'

feature 'User can create answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'create answer', js: true do
      fill_in 'body', with: 'TestAnswer'
      click_on 'Save answer'

      expect(current_path).to eq question_path(question)

      within '.answers' do
        expect(page).to have_content 'TestAnswer'
      end
    end

    scenario 'create an answer with errors', js: true do
      click_on 'Save answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to answer' do
    visit question_path(question)
    fill_in 'body', with: 'TestAnswer'
    click_on 'Save answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end

