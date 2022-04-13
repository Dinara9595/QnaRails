require 'rails_helper'

feature 'User can view questions', %q{
  As an unauthenticated user
  In order to answer questions
} do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2) }

  scenario 'User views all questions' do
    visit questions_path
    expect(page).to have_content "#{questions.first.body}"
    expect(page).to have_content "#{questions.last.title}"
  end
end