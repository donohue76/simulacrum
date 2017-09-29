require 'rails_helper'

feature 'deleting posts' do
  before do
  	user = create(:user)
    post = create(:post, user_id = user.id, caption: 'I am going to delete this post.')

    visit '/'
    sign_in_with_user

    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]").click
    click_link 'Edit Post'
  end

  scenario 'can delete a post' do
    click_link 'Delete Post'

    expect(page).to have_content('Problem solved! Post deleted.')
    expect(page).to_not have_content('I am going to delete this post.')
  end
end