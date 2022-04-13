require 'rails_helper'

feature 'User can create answer', %q{
  As an authenticated user
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'body', with: 'Test answer'
    click_on 'Save answer'

    expect(page).to have_content 'Test answer'
  end

  scenario 'Authenticated user create an answer with errors' do
    sign_in(user)
    visit question_path(question)
    click_on 'Save answer'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Unauthenticated user tries to ask a question' do
    visit question_path(question)
    fill_in 'body', with: 'Test answer'
    click_on 'Save answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end

