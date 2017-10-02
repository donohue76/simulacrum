require 'rails_helper'

feature 'Creating a new user' do
  before do
    visit '/'
    click_link 'Register'
  end

  scenario 'can create a new user via the index page' do
    fill_in 'User name', with: 'webdevdave'
    fill_in 'Email', with: 'webdevdave@gmail.com'
    fill_in 'Password', with: 'password123', match: :first
    fill_in 'Password confirmation', with: 'password123'

    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'requires a user name to successfully create an account' do
    fill_in 'Email', with: 'webdevdave@gmail.com'
    fill_in 'Password', with: 'password123', match: :first
    fill_in 'Password confirmation', with: 'password123'

    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
  end

  scenario 'requires a user name to be more than 4 characters' do
    fill_in 'User name', with: 'h'
    fill_in 'Email', with: 'webdevdave@gmail.com'
    fill_in 'Password', with: 'password123', match: :first
    fill_in 'Password confirmation', with: 'password123'

    click_button 'Sign up'
    expect(page).to have_content("is too short (minimum is 4 characters)")
  end

  scenario 'requires user name to be no longer than 16 characters' do
    fill_in 'User name', with: 'thisisareallyreallylongusername'
    fill_in 'Email', with: 'webdevdave@gmail.com'
    fill_in 'Password', with: 'password123', match: :first
    fill_in 'Password confirmation', with: 'password123'

    click_button 'Sign up'
    expect(page).to have_content("maximum is 16 characters")
  end

end