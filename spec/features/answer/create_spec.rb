require 'rails_helper'

feature 'User can create answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'create answer' do
      fill_in 'Your answer', with: 'TestAnswer'
      click_on 'Create'

      expect(current_path).to eq question_path(question)

      within '.answers' do
        expect(page).to have_content 'TestAnswer'
      end
    end

    scenario 'create an answer with errors' do
      click_on 'Create'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to answer' do
    visit question_path(question)
    fill_in 'Your answer', with: 'TestAnswer'
    click_on 'Create'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end

