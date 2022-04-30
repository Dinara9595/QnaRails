require 'rails_helper'

feature 'User can delete question' do

  given(:user) { create_list(:user, 2) }

  describe 'User can delete' do
    background do
      sign_in(user.first)
      visit questions_path
      ask_question
    end

    scenario 'delete his question' do
      click_on 'Delete'

      expect(page).not_to have_content 'Test question'
      expect(page).not_to have_content 'text text text'
    end

    scenario "delete someone else's question" do
      click_on 'Выйти'
      visit new_user_session_path
      sign_in(user.last)

      click_on 'Delete'

      expect(page).to have_content "#{user.first.email}"
      expect(page).to have_content 'Вы не можете удалить чужой вопрос!'
    end
  end
end

