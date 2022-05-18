require 'rails_helper'

feature 'User can edit his question' do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Unauthenticated user can not edit question' do
    visit questions_path

    expect(page).to have_no_link 'Edit'
  end

  describe 'Authenticated user' do
    background do
      sign_in(question.user)
      visit questions_path
      click_on 'Edit'
    end

    scenario 'edits his question', js: true do
      within '.questions' do
        fill_in 'Title', with: 'Edited question'
        click_on 'Save question'

        expect(page).to have_no_content question.title
        expect(page).to have_content 'Edited question'
        expect(page).to have_no_selector 'textarea'
      end
    end

    scenario 'edits his question with errors', js: true do
      within '.questions' do
        fill_in 'Title', with: ''
        click_on 'Save question'

        expect(page).to have_content question.body
        expect(page).to have_content "Title can't be blank"
      end
    end
  end

  scenario "Authenticated user tries to edit other user's question" do
    sign_in(user)
    visit questions_path

    expect(page).to have_no_link 'Edit'
  end
end