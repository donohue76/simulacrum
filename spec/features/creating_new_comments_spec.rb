require 'rails_helper'

feature 'Creating Comments' do
  scenario 'can comment on an existing post' do
    user = create :user
    post = create(:post, user_id: user.id)
    sign_in_with user
    visit '/'
    fill_in 'Add a comment...', with: 'fast car!\n'
    expect(page).to have_css("div.comment-content", text: 'fast car!')
  end
end