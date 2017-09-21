require 'rails_helper'

feature 'Editing posts' do
	before do
		post = create(:post)
		visit '/'
		print(post.id)
		find(:xpath, '//a[contains(@href, "posts/#{posts.id}")]').click
		click_link 'Edit Post'
	end

	scenario 'Can edit a post' do
		fill_in 'Caption', with: "Oh god, you weren't meant to see this picture!"
		click_button 'Update Post'

		expect(page).to have_content("Post updated.")
		expect(page).to have_content("Oh god, you weren't meant to see this picture!")
	end
end