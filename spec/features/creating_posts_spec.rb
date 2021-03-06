require 'rails_helper'

feature 'Creating posts' do
	before do
		user = create :user
		visit '/'
		log_in_with_user
  end
	scenario 'can create a post' do
		visit '/'
		click_link 'New Post'
		attach_file('Image', "spec/files/images/bugatti.jpg")
		fill_in 'Caption', with: '#zoomzoom'
		click_button 'Create Post'
		expect(page).to have_content('#zoomzoom')
		expect(page).to have_css("img[src*='bugatti.jpg']")
		expect(page).to have_content('webdevdave')
	end

	it 'needs an image to create a post' do
		visit '/'
		click_link 'New Post'
		fill_in 'Caption', with: ' Dude, wheres my car?'
		click_button 'Create Post'
		expect(page).to have_content("Your post couldn't be created! Please add an image and try again.")
	end
end