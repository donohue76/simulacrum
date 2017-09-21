require 'spec_helper'

feature 'Can view individual posts' do
  scenario 'can click and view a single post from the index' do
  	post = create(:post)

  	visit '/'
  	print(post.id)
    find(:xpath, '//a[contains(@href, "posts/#{posts.id}")]').click
    expect(page.current_path).to eq(post_path(post))
  end
end