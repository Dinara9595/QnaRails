require 'rails_helper'

feature 'User can delete question' do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'User can delete their question' do
    sign_in(question.user)
    visit questions_path

    page.find('tr', text: 'Question body test').click_link('Delete')

    expect(page).to have_no_content 'Question title test'
    expect(page).to have_no_content 'Question body test'
  end

  scenario "User can not delete someone else's question" do
    sign_in(user)
    visit questions_path

    expect(page.find('table', text: 'Question title test')).to have_no_button 'Delete'
  end
end

