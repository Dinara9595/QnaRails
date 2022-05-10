require 'rails_helper'

feature 'User can log out' do
  given(:user) { create(:user) }

  scenario 'User can logout' do
    sign_in(user)
    click_on 'Выйти'

    expect(page).to have_content 'Signed out successfully.'
  end
end