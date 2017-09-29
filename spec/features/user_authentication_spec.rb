require 'rails_helper'

feature 'User authentication' do
  before do
    user = create(:user)
  end

  scenario 'can log in from the index via dynamic navbar' do
    visit '/'
    expect(page).not_to have_content("New Post")

    click_link 'Login'
    fill_in 'Email', with: 'webdevdave@gmail.com'
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).not_to have_content('Register')
    expect(page).to have_content('Logout')
  end

  scenario 'can log out once logged in' do
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: 'webdevdave@gmail.com'
    fill_in 'Password', with: 'password123'
    click_button 'Log in'
    click_link 'Logout'

    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  scenario 'cannot view index without logging in' do
    visit '/'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'caoont create a new post without logging in' do
    visit new_post_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

end