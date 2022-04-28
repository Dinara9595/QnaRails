require 'rails_helper'

feature 'User can sign up', %q{
  To create questions and answers
} do

  background { visit new_user_registration_path }


  describe 'User sign up' do
    background do
      fill_in 'Email', with: 'user@test.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'
    end

    scenario 'with valid attributes' do
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario 'with invalid attributes: email' do
      click_on 'Выйти'
      visit new_user_registration_path
      fill_in 'Email', with: 'user@test.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content "Email has already been taken"
    end
  end

  scenario 'User sign up with invalid attributes: password' do
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '1234567'
    click_on 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end