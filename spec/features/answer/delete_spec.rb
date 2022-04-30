require 'rails_helper'

feature 'User can delete answer' do

  given(:user) { create_list(:user, 2) }

  describe 'User can delete' do
    background do
      sign_in(user.first)
      visit questions_path
      ask_question
      fill_in 'body', with: 'Test answer'
      click_on 'Save answer'
    end

    scenario 'delete his answer' do
      page.find('table', text: 'Test answer').click_link('Delete')

      expect(page).not_to have_content 'Test answer'
    end

    scenario "delete someone else's answer" do
      click_on 'Выйти'
      visit new_user_session_path
      sign_in(user.last)
      page.find('table', text: 'Test question').click_link('Show')

      page.find('table', text: 'Test answer').click_link('Delete')

      expect(page).to have_content "#{user.first.email}"
      expect(page).to have_content 'Вы не можете удалить чужой ответ!'
    end
  end
end

